# Basmala audio au début de chaque sourate

## Context

Aujourd'hui la lecture audio du Quran enchaîne uniquement des `AyahSegment` issus de la base de timings du récitateur. L'utilisateur veut entendre **« Bismillâhi-r-Rahmâni-r-Rahîm » avant l'ayah 1 de chaque sourate**, sauf Al-Fatiha (1, où la Basmala *est* l'ayah 1) et At-Tawba (9, qui n'en a pas) — aussi bien quand la lecture démarre sur l'ayah 1 que quand la file passe d'une sourate à la suivante.

### Ce que disent les données (vérifié dans `frontend/assets/db/chiekh voices/`)

Deux récitateurs sont enregistrés dans `cheikh_registry.db` :

| Récitateur | Type | Basmala ? |
|---|---|---|
| `ahmad-alnufais` (défaut) | surah-level | **déjà incluse** dans le clip de l'ayah 1 |
| `as-sudais` | ayah-level | **absente** (un MP3 par ayah) |

Preuve pour le surah-level : sourate 2, ayah 1 = `0 → 11073 ms` alors que « Alif-Lâm-Mîm » dure ~5 s, et les timings mot-à-mot donnent `[[1,0,11139]]` — le premier « mot » couvre Basmala + Alif-Lâm-Mîm. Sourate 10 ayah 1 : `[[1,0,5663],...]` (idem). Sourate 9 ayah 1 : `0 → 10647` sans Basmala. Al-Fatiha ayah 1 : `0 → 4885` = la Basmala seule.

**Conséquence :** insérer un asset Basmala *inconditionnellement* la ferait entendre **deux fois** chez les récitateurs surah-level. L'insertion doit donc être pilotée par une capacité du récitateur.

## Approche

### 1. Capacité par récitateur

`frontend/lib/src/features/home/quran/audio/models/cheikh_reciter.dart` — ajouter un getter :

```dart
/// Les fichiers surah-level (Tarteel/QUL) contiennent la basmala au début du
/// MP3, et le timing de l'ayah 1 démarre à 0 : elle est donc déjà jouée.
/// Les fichiers ayah-level n'ont qu'un seul verset chacun.
bool get providesBasmala => audioType == CheikhAudioType.surahLevel;
```

### 2. Segment Basmala jouable depuis un asset

`frontend/lib/src/features/home/quran/audio/models/ayah_segment.dart` — ajouter un champ `bool fromAsset` (défaut `false`) et un constructeur nommé :

```dart
factory AyahSegment.basmala(int surah) => AyahSegment(
      surah: surah, ayah: 1,           // tag sur l'ayah 1 : le surlignage
      timestampFrom: 0, timestampTo: 0, // se pose déjà sur le bon verset
      fullFile: true, fromAsset: true);
```

Dans `toAudioSource`, si `fromAsset` → `AudioSource.asset(localFilePath, tag: '$surah:basmala')`. Ajouter `fromAsset` à `props`.

### 3. Asset audio

- Déposer le fichier fourni par l'utilisateur en `frontend/assets/audio/basmala.mp3`.
- Déclarer `- assets/audio/basmala.mp3` dans `frontend/pubspec.yaml` (section `assets:`, à côté des entrées `assets/db/...` ligne ~84).
- Constante `kBasmalaAsset` dans le modèle du segment ou dans `audio_download_service.dart`.

### 4. Insertion dans la file

`frontend/lib/src/features/home/quran/audio/vm/usecases/audio_player_uc.dart`, dans `_startPlayback`, **après** la construction de `queue` + `filePaths` et **avant** `_subscribeToIndex(queue)` :

```dart
if (!cheikh.providesBasmala) {
  (queue, filePaths, startIndex) = _insertBasmalas(queue, filePaths, startIndex);
}
```

Helper privé dans le même fichier :
- parcourt la file ; devant toute entrée avec `ayah == 1 && surah != 1 && surah != 9`, insère `AyahSegment.basmala(surah)` + `kBasmalaAsset` dans `filePaths` ;
- incrémente `startIndex` pour chaque insertion faite **à un index ≤ startIndex**, pour que la lecture démarre bien sur la Basmala de l'ayah visé et non un cran plus loin.

Couvre les deux cas demandés : démarrage sur l'ayah 1 (mode `single`, `page`, `surah`) et passage de sourate à sourate à l'intérieur d'une même file.

### 5. Compteur de piste

`AudioPlaying.currentIndex/totalInQueue` alimentent `l10n.audioTrackInfo` dans `recitation_bar.dart:291`. Les entrées Basmala gonfleraient le « x / N ». Deux options, prendre la plus simple :
- filtrer : `total = queue.where((s) => !s.fromAsset).length` et `display = nombre de non-basmala jusqu'à currentIndex` — calculé dans `_startPlayback` / `_onIndexAdvanced` (`copyWithIndex`, `audio_player_state.dart`).

`_onIndexAdvanced` n'a pas besoin d'autre changement : le segment Basmala porte déjà `surah`/`ayah` du verset qui suit, donc le surlignage se pose sur l'ayah 1 pendant la Basmala.

## Fichiers touchés

- `frontend/lib/src/features/home/quran/audio/models/cheikh_reciter.dart`
- `frontend/lib/src/features/home/quran/audio/models/ayah_segment.dart`
- `frontend/lib/src/features/home/quran/audio/vm/usecases/audio_player_uc.dart`
- `frontend/lib/src/features/home/quran/audio/vm/audio_player_state.dart` (compteur)
- `frontend/pubspec.yaml` + `frontend/assets/audio/basmala.mp3`

## Vérification

1. `flutter analyze` propre.
2. Test unitaire du helper d'insertion (aucune infra de test audio requise) : file `[2:1, 2:2, 3:1]` → `[bas(2), 2:1, 2:2, bas(3), 3:1]` ; file `[1:1,1:2]` et `[9:1]` → inchangées ; `startIndex` décalé correctement quand on démarre sur `3:1`.
3. Sur appareil (`flutter run --no-enable-impeller`) :
   - récitateur **As-Sudais** (ayah-level) : ouvrir une page commençant une sourate ≠ 1/9 → la Basmala précède l'ayah 1 ; laisser filer jusqu'à la sourate suivante → Basmala rejouée ; sourate 9 et Al-Fatiha → aucune Basmala ajoutée.
   - récitateur **Al-Nufais** (défaut) : vérifier qu'on entend la Basmala **une seule fois** (celle du MP3), donc aucun doublon.

## Hors périmètre — anomalies constatées à traiter séparément

- `surah-recitation-abdul-rahman-al-sudais.db` : **toutes les lignes de `segments` sont dupliquées** (572 lignes pour la sourate 2 au lieu de 286) → chaque ayah serait jouée deux fois. À dédupliquer (dans le DAO ou dans l'asset).
- DB `ayah-recitation-abdur-rahman-as-sudais-recitation.db` : `verses.ayah_number` est un index **global 1..6236**, alors que `getAyahSegment`/`getAyahsSegments` l'interrogent avec le numéro **local** → `audioSegmentNotFound` pour toute sourate ≠ 1 en mode ayah/page.
- `pubspec.yaml` référence `assets/db/surah-recitation-*.db` et `assets/db/ayah-recitation-*.db`, mais ces fichiers ne sont plus à `assets/db/` (ils sont dans `assets/db/chiekh voices/`, et le fichier ayah-level n'existe qu'en `build/`).
