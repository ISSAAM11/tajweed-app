# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app (physical device or emulator must be connected)
flutter run

# Run on a specific device
flutter run -d <device-id>

# Analyze code
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Generate Drift database code (run after modifying any table in lib/src/database/tables/)
dart run build_runner build --delete-conflicting-outputs

# Build release APK
flutter build apk --release

# Build release App Bundle
flutter build appbundle --release
```

## Git / commits

- **Never add Claude as a co-author.** Do NOT append a `Co-Authored-By: Claude ...`
  trailer (or any Claude/Anthropic attribution) to commit messages or PR bodies.
  Commits should be authored by the user alone.

## Architecture

### Layer Structure

```
lib/src/
├── app/          # App-level: DI bootstrap, design system, GoRouter, environment config
├── base/         # Framework abstractions: BaseBloc, Feature widget, Dependencies interface
├── core/         # Infrastructure: GetIt container, CacheManager, ConnectivityMonitor
├── database/     # Drift ORM: tables, DAOs, migrations, prebuilt.db bootstrap
├── features/     # Self-contained feature modules (see Feature Module Structure below)
└── helpers/      # Stateless utilities (input validation, Quran text parsing)
```

### Feature Module Structure

Every feature follows this layout:

```
features/<name>/
├── binding/      # Registers this feature's dependencies into GetIt
├── data/
│   ├── models/   # API response DTOs
│   └── datasource/ # Interface + implementation (handles API + caching)
├── router/       # GoRoute definition for this feature
└── vm/
    ├── bloc/     # Bloc class (event registration + input controllers)
    ├── events/   # Sealed event classes
    ├── states/   # Sealed state classes
    └── usecases/ # Event handlers as `part of` extensions on the Bloc
```

### Key Abstractions

**`Feature<B extends BaseBloc, S>`** (`lib/src/base/screens/feature.dart`)
The base class for all screens. It handles DI injection, Bloc lifecycle, and wraps the screen in `BlocConsumer`. Subclasses implement `build(BuildContext, S state)` instead of the standard Flutter `build(BuildContext)`. On dispose, it closes the Bloc and unregisters it from GetIt.

```dart
class SignInScreen extends Feature<SignInBloc, SignInState> {
  SignInScreen() : super(dependencies: SignInDependencies().inject);

  @override
  Widget build(BuildContext context, SignInState state) => switch (state) {
    Idle() => ...,
    Loading() => ...,
  };
}
```

**`BaseBloc<E, S>`** (`lib/src/base/bloc/base_bloc.dart`)
Extends `Bloc` with `WidgetsBindingObserver`. Provides `onInit()`, `onReady()`, `onDispose()`, `onPause()`, `onResume()` lifecycle hooks. Every Bloc registers itself as an app lifecycle observer — be mindful of this when many Blocs are active simultaneously.

**`Dependencies`** (`lib/src/base/dependencies/`)
Interface for feature-level DI. Each feature's binding class implements this and is passed as the `dependencies` argument to `Feature`. Dependencies are injected when the screen is first built, and unregistered when disposed.

**`di` / `get<T>()`** (`lib/src/app/binding/app_bindings.dart`)
`di` is the global GetIt container. `get<T>()` is the shorthand accessor used everywhere. Global (app-level) dependencies are registered in `AppBinding`. Feature-level dependencies are registered lazily when their screen opens.

### Database

Drift ORM with a **prebuilt SQLite database** shipped in `assets/db/prebuilt.db`. On first launch, the prebuilt DB is copied to the app documents directory. Schema version is in `AppDatabase.schemaVersion` — bump this and add a migration in `lib/src/database/migrations/` when changing tables.

Tables: `Words`, `Chapters`, `Hizbs`, `Juzs`, `Rukus`, `Sajdahs`, `AyahMetas`, `PageLines`  
DAOs: `QuranListingDao`, `QuranPageDao`

After any change to a table file, regenerate with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Routing

`GoRouter` is configured in `lib/src/app/router/app_router.dart`. Each feature exports its own `GoRoute` and it is registered there. Initial route is determined by `AppConfig.setInitialRoute()` in `main.dart` — checks for `access_token` + `refresh_token` in secure storage; if absent, routes to `/sign-in`.

Current routes: `/sign-in`, `/sign-up`, `/quran-listing`, `/quran-page`, `/tajweed-test`

### Design System

> **Read [`DESIGN_SYSTEM.md`](./DESIGN_SYSTEM.md) before writing any UI code.** It is the single source of truth for colors, fonts, sizes, spacing, and asset paths.

**Hard rules — no exceptions:**

- **No hardcoded colors** — use `AppColors.*`
- **No hardcoded font sizes** — use `FontSizes.*`
- **No hardcoded dimensions** — use `AppMetrics.*` (spacing, padding, heights, radii)
- **No raw asset strings** — use `AppImages.*`
- **No raw `TextStyle(...)`** — start from `AppFonts.*` and chain `.withSize()`, `.withColor()`, `.semiBold()`, etc.

**Quick reference:**

```dart
// Color
color: AppColors.primary

// Text style (always chain from AppFonts)
style: AppFonts.lato.withSize(FontSizes.subtitle).withColor(AppColors.greyDarkest).medium()

// Spacing
SizedBox(height: AppMetrics.spacing.sm)   // 16
Padding(padding: EdgeInsets.symmetric(horizontal: AppMetrics.scaffold.horizontalBodyPadding))

// Image
Image.asset(AppImages.quranImage)
```

**Adding a new component with custom sizing:** add a `_MyWidget` class in `lib/src/app/design/metrics/parts/components.dart` and register it as `static const myWidget = _MyWidget._()` in `AppMetrics`. Never put magic numbers directly in a widget file.

### Localization (i18n)

The app ships with **English (default) and Arabic** and uses Flutter's official i18n stack — no third-party translation package. `flutter_localizations` + `intl` are already in `pubspec.yaml`, and `flutter: generate: true` is set so `flutter gen-l10n` produces `AppLocalizations` on every `flutter pub get`.
i interupt you
**Files**

- `l10n.yaml` (project root) — gen-l10n config.
- `lib/l10n/app_en.arb` — English source strings (template).
- `lib/l10n/app_ar.arb` — Arabic translations.
- `lib/l10n/app_localizations*.dart` — generated, **committed**, do not edit by hand.
- `lib/src/core/services/locale_preference_service.dart` — SharedPreferences-backed persistence (key: `app_locale`).
- `lib/src/app/locale/locale_bloc.dart` — global `Cubit<AppLanguage>`, registered as a singleton in `AppBinding.asynchronous()`. `MaterialApp.router` rebuilds on its state changes (see `lib/src/app/app_widget.dart`).
- `lib/src/features/settings/` — Settings feature with the live language toggle.

**Hard rules — no exceptions:**

- **No raw user-facing strings in widgets.** Every visible label, hint, button title, dialog title, snackbar message, etc. must come from `AppLocalizations.of(context)!.<key>`. Quranic verse content (Uthmanic font) and brand strings ("Tajweed AI", "Google", "Facebook", "Apple") are the only exceptions.
- **Both ARB files must have every key.** If you add a key to `app_en.arb`, add the Arabic translation in `app_ar.arb` in the same edit. Missing keys become **compile errors**, not runtime "not found".
- **Never hardcode `Directionality(textDirection: ...)` in a screen body.** The locale drives `TextDirection` automatically; let it.
- **AppBars are LTR-locked.** Wrap every `AppBar` (or its surrounding `PreferredSize`) in `Directionality(textDirection: TextDirection.ltr, ...)` so back / menu stay on the left and search / settings stay on the right in both languages.
- **Quran page swipe is RTL-locked.** The `PageView` in `lib/src/features/home/quran/page/widgets/quran_page_body.dart` is wrapped in `Directionality.rtl` — keep it that way regardless of locale.
- **Don't add a third-party i18n package** (`easy_localization`, `slang`, etc.). The official tooling gives compile-time safety and integrates with `flutter_localizations` for free.

**Adding a new screen — translation checklist:**

1. **Identify every user-facing string** in the new widget. Skip Quranic content and brand strings.
2. **Add a key to BOTH ARB files** — `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`. Use a feature-prefixed name (e.g., `homeSectionTitle`, `authSignIn`, `partitionJuz`). Reuse existing keys when the meaning matches.
3. **Run `flutter pub get`** to regenerate `AppLocalizations` (or `flutter gen-l10n`).
4. **Reference the key** from the widget:
   ```dart
   import 'package:tajweed_ai/l10n/app_localizations.dart';
   ...
   final l10n = AppLocalizations.of(context)!;
   Text(l10n.mySectionTitle);
   ```
5. **AppBar:** wrap in `Directionality.ltr` (see Hard rules).
6. **Body:** no hardcoded `Directionality.rtl` — let the locale drive it.
7. **Locale-aware data fields** (e.g., a model with both `nameSimple` and `nameArabic`): pick at render time:
   ```dart
   final isArabic = Localizations.localeOf(context).languageCode == 'ar';
   final display = isArabic ? item.nameArabic : item.nameSimple;
   ```
8. **Bloc-emitted messages**: do not emit raw human text from a usecase. Either emit a translation key string (e.g., `Error('emailAlreadyInUse')`) and resolve at the view, or extend the state with a sealed `ErrorReason` enum and switch on it in the snackbar call site. The view layer is the only place that calls `AppLocalizations.of(context)`.
9. **Run `flutter analyze`** — must report zero new issues.
10. **Manually verify** by toggling Arabic in `/settings` and confirming the new screen flips correctly.

**Quick reference:**

```dart
// Adding a new string:
//   lib/l10n/app_en.arb:  "welcomeMessage": "Welcome"
//   lib/l10n/app_ar.arb:  "welcomeMessage": "مرحباً"
// Then `flutter pub get`, then:
final l10n = AppLocalizations.of(context)!;
Text(l10n.welcomeMessage);

// With a placeholder:
//   "versesCount": "{count} verses"
//   "@versesCount": { "placeholders": { "count": { "type": "int" } } }
Text(l10n.versesCount(7));   // "7 verses" / "7 آية"

// LTR-locked AppBar:
appBar: PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: AppBar(...),
  ),
);
```

### Local Packages

Two internal packages live in `packages/`:

- `cg_core_defs` — core definitions and abstractions (`InputControl`, `Debugger`, `ModelingProtocol`, etc.)
- `generic_requester` — HTTP client wrapper around Dio

### State Pattern

States and events are sealed classes extending `Equatable`. Standard state set: `Idle`, `Loading`, `Success`, `Error`. Use cases (event handlers) are written as `part of` extensions on the Bloc file to keep the Bloc class itself lean.
