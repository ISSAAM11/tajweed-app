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

> **Dev mode note:** `main.dart` currently hardcodes the initial route to `/quran-listing`, bypassing auth. To test the auth flow, remove the `devRoute` argument from `AppConfig.setInitialRoute(...)` in `main.dart`.

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

### Local Packages

Two internal packages live in `packages/`:
- `cg_core_defs` — core definitions and abstractions (`InputControl`, `Debugger`, `ModelingProtocol`, etc.)
- `generic_requester` — HTTP client wrapper around Dio

### State Pattern

States and events are sealed classes extending `Equatable`. Standard state set: `Idle`, `Loading`, `Success`, `Error`. Use cases (event handlers) are written as `part of` extensions on the Bloc file to keep the Bloc class itself lean.
