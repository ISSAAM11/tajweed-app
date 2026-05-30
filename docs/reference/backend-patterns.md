# BACKEND PATTERNS - CLAUDE CODE REFERENCE

> INSTRUCTION: Ce fichier contient les patterns et regles pour le code backend Django/DRF.
> Consulter ce fichier lors de /add-feature pour generer du code conforme.

---

## DECISIONS RAPIDES

### Ou mettre la logique metier ?
```
Views/ViewSets      → Routing, permissions, serialization uniquement
Services            → Logique metier complexe, operations multi-modeles
Selectors           → Requetes complexes, aggregations, recherche
Models              → Validation simple, proprietes calculees
Serializers         → Validation input, transformation output
```

### Quel type de View utiliser ?
```
CRUD complet sur un model        → ModelViewSet
CRUD partiel (list+retrieve)     → ReadOnlyModelViewSet
Actions custom multiples         → ViewSet + @action
Une seule operation              → APIView ou generics.*
```

### Comment optimiser les queries ?
```
ForeignKey (1 query)        → select_related('field')
ManyToMany/Reverse FK       → prefetch_related('field')
Les deux combines           → select_related().prefetch_related()
Champs inutiles             → defer('heavy_field') ou only('field1', 'field2')
Bulk operations             → bulk_create(), bulk_update()
```

### Quel Serializer utiliser ?
```
Lecture simple              → ModelSerializer avec fields explicites
Creation/Update             → Serializer separe avec validation
Relations nested read       → Nested serializer (read_only=True)
Relations nested write      → Override create()/update()
```

---

## PATTERNS MODELS

### Model de base avec timestamps
```python
# apps/core/models.py
from django.db import models

class TimeStampedModel(models.Model):
    """Model abstrait avec timestamps automatiques."""
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
```

### Model complet
```python
# apps/products/models.py
from django.db import models
from apps.core.models import TimeStampedModel

class Product(TimeStampedModel):
    """Model produit avec bonnes pratiques."""

    # Relations - toujours definir related_name
    owner = models.ForeignKey(
        'users.User',
        on_delete=models.CASCADE,
        related_name='products',
    )
    category = models.ForeignKey(
        'Category',
        on_delete=models.PROTECT,  # Empeche suppression si produits lies
        related_name='products',
    )

    # Champs
    name = models.CharField(max_length=255)
    slug = models.SlugField(unique=True, db_index=True)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    is_active = models.BooleanField(default=True, db_index=True)

    class Meta:
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['is_active', '-created_at']),
            models.Index(fields=['category', 'is_active']),
        ]

    def __str__(self) -> str:
        return self.name

    @property
    def is_available(self) -> bool:
        """Propriete calculee (pas de query)."""
        return self.is_active and self.stock > 0
```

### Choix pour on_delete
```python
on_delete=models.CASCADE    # Supprime les objets lies (defaut pour FK)
on_delete=models.PROTECT    # Empeche la suppression si objets lies
on_delete=models.SET_NULL   # Met a null (necessite null=True)
on_delete=models.SET_DEFAULT # Met la valeur default
on_delete=models.DO_NOTHING # Ne fait rien (dangereux)
```

---

## PATTERNS SERIALIZERS

### Serializer lecture
```python
# apps/products/serializers.py
from rest_framework import serializers
from .models import Product

class ProductSerializer(serializers.ModelSerializer):
    """Serializer pour lecture (list/retrieve)."""
    owner_name = serializers.CharField(source='owner.full_name', read_only=True)
    category_name = serializers.CharField(source='category.name', read_only=True)

    class Meta:
        model = Product
        fields = ['id', 'name', 'slug', 'description', 'price', 'is_active',
                  'owner_name', 'category_name', 'created_at', 'updated_at']
        read_only_fields = ['id', 'slug', 'created_at', 'updated_at']
```

### Serializer creation avec validation
```python
class ProductCreateSerializer(serializers.ModelSerializer):
    """Serializer pour creation avec validation."""

    class Meta:
        model = Product
        fields = ['name', 'description', 'price', 'category']

    def validate_price(self, value):
        """Validation niveau champ."""
        if value <= 0:
            raise serializers.ValidationError("Le prix doit etre positif.")
        return value

    def validate(self, data):
        """Validation niveau objet (multi-champs)."""
        if data.get('name') and len(data['name']) < 3:
            raise serializers.ValidationError({
                'name': "Le nom doit avoir au moins 3 caracteres."
            })
        return data

    def create(self, validated_data):
        """Override pour logique custom."""
        from django.utils.text import slugify
        validated_data['slug'] = slugify(validated_data['name'])
        validated_data['owner'] = self.context['request'].user
        return super().create(validated_data)
```

### Serializer avec nested relations
```python
class ProductDetailSerializer(serializers.ModelSerializer):
    """Serializer avec relations nested (lecture)."""
    category = CategorySerializer(read_only=True)
    owner = UserSerializer(read_only=True)
    tags = TagSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = '__all__'
```

### Serializer nested writable
```python
class OrderCreateSerializer(serializers.ModelSerializer):
    """Serializer avec nested writable."""
    items = OrderItemSerializer(many=True)

    class Meta:
        model = Order
        fields = ['customer', 'items', 'notes']

    def create(self, validated_data):
        items_data = validated_data.pop('items')
        order = Order.objects.create(**validated_data)
        for item_data in items_data:
            OrderItem.objects.create(order=order, **item_data)
        return order

    def update(self, instance, validated_data):
        items_data = validated_data.pop('items', None)
        # Update order fields
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        # Replace items if provided
        if items_data is not None:
            instance.items.all().delete()
            for item_data in items_data:
                OrderItem.objects.create(order=instance, **item_data)
        return instance
```

---

## PATTERNS VIEWSETS

### ModelViewSet complet
```python
# apps/products/views.py
from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

from .models import Product
from .serializers import ProductSerializer, ProductCreateSerializer, ProductDetailSerializer
from .services import ProductService
from apps.core.permissions import IsOwnerOrReadOnly

class ProductViewSet(viewsets.ModelViewSet):
    """
    ViewSet pour les produits.

    list: GET /products/
    create: POST /products/
    retrieve: GET /products/{id}/
    update: PUT /products/{id}/
    partial_update: PATCH /products/{id}/
    destroy: DELETE /products/{id}/
    """
    queryset = Product.objects.all()
    permission_classes = [IsAuthenticated, IsOwnerOrReadOnly]

    # Filtrage, recherche, tri
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['category', 'is_active']
    search_fields = ['name', 'description']
    ordering_fields = ['price', 'created_at', 'name']
    ordering = ['-created_at']  # Tri par defaut

    def get_queryset(self):
        """Optimiser les queries avec select_related/prefetch_related."""
        return (
            self.queryset
            .select_related('owner', 'category')
            .prefetch_related('tags')
            .filter(is_active=True)
        )

    def get_serializer_class(self):
        """Serializer different selon l'action."""
        if self.action == 'create':
            return ProductCreateSerializer
        if self.action == 'retrieve':
            return ProductDetailSerializer
        return ProductSerializer

    def perform_create(self, serializer):
        """Hook pour associer l'owner a la creation."""
        serializer.save(owner=self.request.user)

    @action(detail=True, methods=['post'])
    def archive(self, request, pk=None):
        """POST /products/{id}/archive/"""
        product = self.get_object()
        ProductService.archive(product)
        return Response({'status': 'archived'})

    @action(detail=False, methods=['get'])
    def my_products(self, request):
        """GET /products/my_products/"""
        products = self.get_queryset().filter(owner=request.user)
        serializer = self.get_serializer(products, many=True)
        return Response(serializer.data)
```

### Router configuration
```python
# apps/products/urls.py
from rest_framework.routers import DefaultRouter
from .views import ProductViewSet

router = DefaultRouter()
router.register(r'products', ProductViewSet, basename='product')

urlpatterns = router.urls
```

---

## PATTERNS SERVICES

### Service Layer
```python
# apps/products/services.py
from django.db import transaction
from django.core.exceptions import ValidationError
from typing import Optional

from .models import Product
from apps.notifications.services import NotificationService

class ProductService:
    """Service pour la logique metier des produits."""

    @staticmethod
    def create(*, owner, name: str, price: float, category, **kwargs) -> Product:
        """
        Cree un nouveau produit.

        Utiliser keyword-only args (*) pour clarte.
        """
        if price <= 0:
            raise ValidationError("Le prix doit etre positif")

        with transaction.atomic():
            from django.utils.text import slugify
            product = Product.objects.create(
                owner=owner,
                name=name,
                slug=slugify(name),
                price=price,
                category=category,
                **kwargs
            )
            # Actions post-creation
            NotificationService.notify_new_product(product)
            return product

    @staticmethod
    def archive(product: Product) -> Product:
        """Archive un produit."""
        product.is_active = False
        product.save(update_fields=['is_active', 'updated_at'])
        return product

    @staticmethod
    def update_price(product: Product, new_price: float) -> Product:
        """Met a jour le prix avec historique."""
        if new_price <= 0:
            raise ValidationError("Le prix doit etre positif")

        with transaction.atomic():
            old_price = product.price
            product.price = new_price
            product.save(update_fields=['price', 'updated_at'])

            # Log du changement
            PriceHistory.objects.create(
                product=product,
                old_price=old_price,
                new_price=new_price
            )
            return product

    @staticmethod
    def bulk_archive(product_ids: list[int]) -> int:
        """Archive plusieurs produits efficacement."""
        return Product.objects.filter(id__in=product_ids).update(is_active=False)
```

---

## PATTERNS SELECTORS

### Selector pour requetes complexes
```python
# apps/products/selectors.py
from django.db.models import QuerySet, Count, Avg, Q, F
from .models import Product

class ProductSelector:
    """Selector pour requetes complexes sur les produits."""

    @staticmethod
    def get_active() -> QuerySet[Product]:
        """Produits actifs."""
        return Product.objects.filter(is_active=True)

    @staticmethod
    def get_by_category(category_id: int) -> QuerySet[Product]:
        """Produits d'une categorie avec optimisation."""
        return (
            Product.objects
            .filter(category_id=category_id, is_active=True)
            .select_related('owner', 'category')
        )

    @staticmethod
    def get_popular(limit: int = 10) -> QuerySet[Product]:
        """Produits populaires (plus commandes)."""
        return (
            Product.objects
            .filter(is_active=True)
            .annotate(order_count=Count('orders'))
            .order_by('-order_count')[:limit]
        )

    @staticmethod
    def search(query: str) -> QuerySet[Product]:
        """Recherche dans nom et description."""
        return (
            Product.objects
            .filter(
                Q(name__icontains=query) | Q(description__icontains=query),
                is_active=True
            )
            .select_related('category')
        )

    @staticmethod
    def get_price_stats_by_category() -> list[dict]:
        """Stats prix par categorie."""
        return list(
            Product.objects
            .filter(is_active=True)
            .values('category__name')
            .annotate(
                count=Count('id'),
                avg_price=Avg('price'),
                min_price=Min('price'),
                max_price=Max('price')
            )
        )

    @staticmethod
    def get_discounted() -> QuerySet[Product]:
        """Produits avec reduction (compare deux champs)."""
        return Product.objects.filter(
            is_active=True,
            sale_price__lt=F('price')
        )
```

---

## PATTERNS PERMISSIONS

### Permissions custom
```python
# apps/core/permissions.py
from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    """Lecture pour tous, ecriture pour le proprietaire."""

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.owner == request.user

class IsAdminOrReadOnly(permissions.BasePermission):
    """Lecture pour tous, ecriture pour les admins."""

    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_staff

class IsOwner(permissions.BasePermission):
    """Acces uniquement au proprietaire."""

    def has_object_permission(self, request, view, obj):
        return obj.owner == request.user
```

### Permissions composees
```python
from rest_framework.permissions import IsAuthenticated, SAFE_METHODS

class ReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.method in SAFE_METHODS

# Usage dans une view:
permission_classes = [IsAuthenticated | ReadOnly]  # Auth OU readonly
permission_classes = [IsAuthenticated, IsOwnerOrReadOnly]  # Auth ET owner
```

---

## PATTERNS PAGINATION

### Pagination globale (settings.py)
```python
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 20,
}
```

### Pagination custom
```python
# apps/core/pagination.py
from rest_framework.pagination import PageNumberPagination, CursorPagination

class StandardResultsSetPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100

class LargeResultsSetPagination(PageNumberPagination):
    page_size = 100
    page_size_query_param = 'page_size'
    max_page_size = 1000

class CreatedAtCursorPagination(CursorPagination):
    """Pagination cursor pour gros datasets (plus performant)."""
    page_size = 50
    ordering = '-created_at'
    cursor_query_param = 'cursor'
```

### Usage par view
```python
class ProductViewSet(viewsets.ModelViewSet):
    pagination_class = StandardResultsSetPagination
```

---

## PATTERNS THROTTLING

### Configuration globale
```python
# settings.py
REST_FRAMEWORK = {
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle'
    ],
    'DEFAULT_THROTTLE_RATES': {
        'anon': '100/hour',
        'user': '1000/hour',
        'burst': '60/min',
    }
}
```

### Throttle custom par scope
```python
# apps/core/throttling.py
from rest_framework.throttling import UserRateThrottle

class BurstRateThrottle(UserRateThrottle):
    scope = 'burst'

class SustainedRateThrottle(UserRateThrottle):
    scope = 'sustained'
```

---

## PATTERNS SIGNALS

### Signal post_save
```python
# apps/products/signals.py
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from .models import Product

@receiver(post_save, sender=Product)
def product_post_save(sender, instance, created, **kwargs):
    """Execute apres la sauvegarde d'un produit."""
    if kwargs.get('raw'):  # Skip pendant loaddata
        return

    if created:
        # Nouveau produit
        NotificationService.notify_new_product(instance)
    else:
        # Mise a jour
        pass

@receiver(pre_save, sender=Product)
def product_pre_save(sender, instance, **kwargs):
    """Execute avant la sauvegarde."""
    if not instance.slug:
        from django.utils.text import slugify
        instance.slug = slugify(instance.name)
```

### Enregistrement dans AppConfig
```python
# apps/products/apps.py
from django.apps import AppConfig

class ProductsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.products'

    def ready(self):
        from . import signals  # noqa
```

---

## PATTERNS TRANSACTIONS

### Atomic decorator
```python
from django.db import transaction

@transaction.atomic
def create_order_with_items(user, items_data):
    """Tout ou rien - rollback si erreur."""
    order = Order.objects.create(user=user)
    for item_data in items_data:
        OrderItem.objects.create(order=order, **item_data)
    return order
```

### Atomic context manager
```python
def transfer_funds(from_account, to_account, amount):
    with transaction.atomic():
        from_account.balance -= amount
        from_account.save()

        to_account.balance += amount
        to_account.save()

        Transfer.objects.create(
            from_account=from_account,
            to_account=to_account,
            amount=amount
        )
```

### Savepoints pour rollback partiel
```python
from django.db import transaction

@transaction.atomic
def complex_operation():
    # Operation 1 - doit reussir
    create_parent()

    try:
        with transaction.atomic():
            # Operation 2 - peut echouer
            generate_relationships()
    except IntegrityError:
        # Rollback seulement operation 2
        handle_exception()

    # Operation 3 - continue meme si 2 a echoue
    add_children()
```

---

## ANTI-PATTERNS - NE JAMAIS FAIRE

```python
# INTERDIT: Query dans une boucle (N+1)
for product in Product.objects.all():
    print(product.owner.name)  # 1 query par iteration!

# CORRECT: select_related
for product in Product.objects.select_related('owner').all():
    print(product.owner.name)  # 1 seule query

# INTERDIT: Logique metier dans la view
class ProductViewSet(viewsets.ModelViewSet):
    def create(self, request):
        # 50 lignes de logique metier ici... NON!
        pass

# CORRECT: Deleguer au service
class ProductViewSet(viewsets.ModelViewSet):
    def perform_create(self, serializer):
        ProductService.create(**serializer.validated_data)

# INTERDIT: Validation dans la view
def create(self, request):
    if request.data['price'] <= 0:  # NON!
        return Response({'error': '...'}, status=400)

# CORRECT: Validation dans le serializer
def validate_price(self, value):
    if value <= 0:
        raise serializers.ValidationError("Prix invalide")
    return value

# INTERDIT: Catch-all exception
try:
    do_something()
except Exception:  # NON!
    pass

# CORRECT: Exceptions specifiques
try:
    do_something()
except ValidationError as e:
    return Response({'error': str(e)}, status=400)
except Product.DoesNotExist:
    raise Http404()

# INTERDIT: update() sans update_fields
product.save()  # Met a jour TOUS les champs

# CORRECT: Specifier les champs modifies
product.save(update_fields=['price', 'updated_at'])

# INTERDIT: Hardcoder les IDs
category = Category.objects.get(id=1)  # NON!

# CORRECT: Utiliser des constantes ou lookups
category = Category.objects.get(slug='electronics')
```

---

## STRUCTURE FICHIERS

```
backend/
├── config/
│   ├── settings/
│   │   ├── base.py          # Settings communs
│   │   ├── development.py   # Dev settings
│   │   └── production.py    # Prod settings
│   ├── urls.py
│   └── wsgi.py
├── apps/
│   ├── core/                # App commune
│   │   ├── models.py        # TimeStampedModel, etc.
│   │   ├── permissions.py   # Permissions custom
│   │   ├── pagination.py    # Pagination custom
│   │   └── exceptions.py    # Exceptions custom
│   ├── users/               # Auth
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   └── urls.py
│   └── [domain]/            # App metier
│       ├── models.py
│       ├── serializers.py
│       ├── views.py
│       ├── services.py      # Logique metier
│       ├── selectors.py     # Requetes complexes
│       ├── signals.py       # Signals
│       ├── urls.py
│       └── tests/
│           ├── test_models.py
│           ├── test_serializers.py
│           ├── test_views.py
│           └── test_services.py
└── tests/                   # Tests d'integration
```

---

## CONVENTIONS NOMMAGE

| Element | Format | Exemple |
|---------|--------|---------|
| App | snake_case | `user_profiles` |
| Model | PascalCase singulier | `Product` |
| Serializer | Model + Serializer | `ProductSerializer` |
| ViewSet | Model + ViewSet | `ProductViewSet` |
| Service | Model + Service | `ProductService` |
| Selector | Model + Selector | `ProductSelector` |
| URL name | app:model-action | `products:product-list` |
| related_name | snake_case pluriel | `products`, `order_items` |

---

## OPTIMISATION QUERIES

### Utiliser explain() pour debug
```python
print(Product.objects.filter(is_active=True).explain())
```

### Patterns d'optimisation
```python
# select_related: ForeignKey, OneToOne (JOIN)
Product.objects.select_related('owner', 'category')

# prefetch_related: ManyToMany, reverse FK (2 queries)
Product.objects.prefetch_related('tags', 'reviews')

# Combiner les deux
Product.objects.select_related('owner').prefetch_related('tags')

# defer: Exclure des champs lourds
Product.objects.defer('description', 'full_content')

# only: Inclure seulement certains champs
Product.objects.only('id', 'name', 'price')

# values/values_list: Retourner des dicts/tuples (pas d'objets)
Product.objects.values('id', 'name')
Product.objects.values_list('id', flat=True)

# Bulk operations
Product.objects.bulk_create([Product(...), Product(...)])
Product.objects.bulk_update(products, ['price', 'is_active'])
Product.objects.filter(category_id=1).update(is_active=False)
```

---

## CHECKLIST AVANT GENERATION

Avant de generer du code backend:
- [ ] select_related/prefetch_related pour eviter N+1
- [ ] Logique metier dans services (pas dans views)
- [ ] Validation dans serializers
- [ ] Permissions definies sur chaque ViewSet
- [ ] Transactions pour operations multi-modeles
- [ ] Tests pour models, serializers, views, services
- [ ] Index sur les champs frequemment filtres
- [ ] update_fields sur save() partiel
- [ ] Type hints sur les fonctions de service
