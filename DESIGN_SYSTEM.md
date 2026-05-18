# Design System — Tajweed AI

All design tokens live under `lib/src/app/design/`. Never hardcode colors, sizes, fonts, or asset paths in widgets — always reference the constants below.

---

## Colors — `AppColors`

The palette is built around **elegant gold** as the brand color on a white scaffold.

| Name | Hex | Use |
|---|---|---|
| `primary` | `#D4AF37` | Rich Gold — buttons, active states, borders |
| `primaryLight` | `#E6C866` | Light Gold — highlights, Quran text |
| `primaryDark` | `#B8941F` | Dark Gold — pressed states |
| `secondary` | `#F4E4BC` | Cream Gold — card backgrounds, chips |
| `tertiary` | `#8B7355` | Warm Brown — accents |
| `scaffold` | `#FFFFFF` | Screen background |
| `greyDarkest` | `#413E40` | AppBar background, body text |
| `greyDark` | `#2C2C2C` | Dark text |
| `greyMedium` | `#555555` | Secondary text |
| `greyRegular` | `#6D7475` | Hint text |
| `greyLight` | `#E1E2E5` | Borders, dividers |
| `greyBackground` | `#F8F9FA` | Input fill, card background |
| `error` | `#E74C3C` | Validation errors |
| `success` | `#27AE60` | Success states |
| `warning` | `#F39C12` | Warnings |
| `info` | `#3498DB` | Info states |

### Gradients
```dart
AppColors.primaryGradient   // Gold left-to-right: light → rich → dark
AppColors.shimmerGradient   // 5-stop shimmer effect
AppColors.secondaryGradient // Cream → light gold → rich gold
AppColors.darkGradient      // Dark gold → rich → light
AppColors.highlightGradient // White → cream → gold
```

---

## Typography — `AppFonts` + `FontSizes` + `TextStyleExt`

### Font Families
| Constant | Font | Default color | Use |
|---|---|---|---|
| `AppFonts.lato` | Lato | white | UI labels, body text |
| `AppFonts.poppins` | Poppins | white | UI alternative |
| `AppFonts.nunito` | Nunito | — | AppBar titles |
| `AppFonts.helvetica` | Helvetica | white | `AppStyles` pre-built text styles |
| `AppFonts.uthmanicHafsFont` | UthmanicHafsV18 | `primaryLight` | Quran Arabic text |
| `AppFonts.surahNamesFont` | SurahNameV4 | `primaryLight` | Surah name glyphs |

### Size Scale — `FontSizes`
| Constant | Size | Use |
|---|---|---|
| `headline1` | 24 | Page titles |
| `headline2` | 22 | Section headings |
| `headline3` | 20 | Card headings |
| `headline4` | 18 | Sub-headings |
| `title` | 16 | List item titles |
| `subtitle` | 14 | Descriptions, metadata |
| `indication` | 12 | Labels, tags |
| `caption` | 10 | Timestamps, fine print |

### `TextStyleExt` — chainable modifiers
Start from a font constant and chain modifiers:

```dart
// Weight
AppFonts.lato.thin()        // w100
AppFonts.lato.light()       // w300
AppFonts.lato.regular()     // w400
AppFonts.lato.medium()      // w500
AppFonts.lato.semiBold()    // w600
AppFonts.lato.bold()        // w700
AppFonts.lato.extraBold()   // w800

// Size & color
AppFonts.lato.withSize(FontSizes.subtitle)
AppFonts.lato.withColor(AppColors.greyDarkest)
AppFonts.lato.withHeight(1.4)
AppFonts.lato.italic()

// Semantic color shortcuts
AppFonts.lato.white()
AppFonts.lato.dark()
AppFonts.lato.primary()
AppFonts.lato.error()
AppFonts.lato.greyMedium()
// ... (all AppColors variants available)
```

**Example from the codebase:**
```dart
Text(
  "Last read",
  style: AppFonts.lato
      .withSize(FontSizes.indication)
      .withColor(AppColors.greyDarkest)
      .medium(),
)
```

### `AppStyles` — pre-built Helvetica styles
Quick access with no chaining needed:
```dart
AppStyles.headline1  // Helvetica 24
AppStyles.title      // Helvetica 16
AppStyles.subtitle   // Helvetica 14
// etc.
```

---

## Metrics — `AppMetrics`

All dimension values. Access via `AppMetrics.<section>.<property>`.

### Global defaults
```dart
AppMetrics.defaultRadius     // 12.0
AppMetrics.defaultElevation  // 8.0
```

### Scaffold body padding
```dart
AppMetrics.scaffold.topBodyPadding          // 25
AppMetrics.scaffold.horizontalBodyPadding   // 20
AppMetrics.scaffold.bottomBodyPadding       // 50
```

### Spacing scale — `AppMetrics.spacing`
```dart
AppMetrics.spacing.xs   // 8
AppMetrics.spacing.sm   // 16
AppMetrics.spacing.md   // 24
AppMetrics.spacing.lg   // 32
AppMetrics.spacing.xl   // 48
AppMetrics.spacing.xxl  // 64
AppMetrics.spacing.section       // 40
AppMetrics.spacing.largeSection  // 56
```

### AppBar — `AppMetrics.topBar`
```dart
AppMetrics.topBar.height        // 55
AppMetrics.topBar.elevation     // 0
AppMetrics.topBar.leadingWidth  // 60
AppMetrics.topBar.buttonWidth   // 60
```

### Bottom Bar — `AppMetrics.bottomBar`
```dart
AppMetrics.bottomBar.height      // 90
AppMetrics.bottomBar.buttonSize  // 80
AppMetrics.bottomBar.radius      // 8
```

### Buttons — `AppMetrics.buttons`
```dart
AppMetrics.buttons.radius                    // 50 (fully rounded)
AppMetrics.buttons.elevated.height           // 40
AppMetrics.buttons.elevated.elevation        // 0
AppMetrics.buttons.text.height               // 40
AppMetrics.buttons.floating.height           // 45
AppMetrics.buttons.floating.iconSize         // 28
AppMetrics.buttons.floating.radius           // 10
```

### Inputs — `AppMetrics.inputs`
```dart
AppMetrics.inputs.height                     // 40
AppMetrics.inputs.radius                     // 12
AppMetrics.inputs.borderWidth                // 1.5
AppMetrics.inputs.horizontalContentPadding  // 20
AppMetrics.inputs.verticalContentPadding    // 13
AppMetrics.inputs.passwordInputMaxLength    // 12
AppMetrics.inputs.maxLength                 // 50
AppMetrics.inputs.inputsAutovalidationMode  // AutovalidateMode.disabled
```

### Component-specific metrics
```dart
// Last Selected Surah widget
AppMetrics.lastSelectedSurahWidget.height           // 160
AppMetrics.lastSelectedSurahWidget.borderRadius     // 20
AppMetrics.lastSelectedSurahWidget.quranImageSize   // 165
AppMetrics.lastSelectedSurahWidget.lastReadIconSize // 20
AppMetrics.lastSelectedSurahWidget.columnSpacing    // 7
AppMetrics.lastSelectedSurahWidget.buttonBorderRadius // 30

// Surah name card
AppMetrics.surahNameCard.numberContainerSize   // 36
AppMetrics.surahNameCard.numberFontSize        // 14
AppMetrics.surahNameCard.englishNameFontSize   // 16
AppMetrics.surahNameCard.arabicNameFontSize    // 21
```

> When adding a new widget with specific sizing, add a new `_MyWidgetName` class in `lib/src/app/design/metrics/parts/components.dart` and register it as a `static const` in `AppMetrics`.

---

## Tajweed Colors — `TajweedStyles` + `tajweedStyleMap`

Each Tajweed rule has a dedicated `TextStyle` with a specific color. These are used by the Quran page renderer to color-code recitation rules.

| Rule key | Color |
|---|---|
| `ham_wasl` | Grey `#AAAAAA` |
| `madda_normal` | Blue `#537FFF` |
| `madda_permissible` | Orange `#F38E02` |
| `madda_necessary` | Dark Blue `#000EBC` |
| `madda_obligatory` | Pink `#F2007F` |
| `qalaqah` | Cyan `#009EE6` |
| `ikhafa` | Purple `#9400A8` |
| `ikhafa_shafawi` | Magenta `#D500B7` |
| `iqlab` | Light Blue `#26BFFD` |
| `idgham_ghunnah` | Green `#169200` |
| `idgham_shafawi` | Light Green `#58B800` |
| `ghunnah` | Orange `#FF7E1E` |

Use `tajweedStyleMap[ruleKey]` to look up a style by its string key (as parsed from the Quran text HTML).

---

## Asset Paths — `AppImages`

```dart
AppImages.backgroundLastRead    // assets/images/home/listing/background-last-read.png
AppImages.surahNumberBackground // assets/images/home/listing/surah-number-bg.png
AppImages.lastReadIcon          // assets/images/home/listing/last-read-icon.png
AppImages.quranImage            // assets/images/home/listing/quran-image.png
AppImages.appLogo               // assets/images/dexter_logo.jpeg
```

When adding a new image, add it to `assets/images/`, declare it in `pubspec.yaml` under `flutter.assets`, and add a constant to `AppImages`.

---

## Theme — `AppThemes`

Configured in `lib/src/app/design/themes/app_themes.dart`.

- `AppThemes.light` — the active theme (Material 3, gold palette, white scaffold, dark `#413E40` AppBar)
- `AppThemes.dark` — partial dark theme (copies light, overrides scaffold and surface colors). Not fully implemented.

The theme applies default styles globally so widgets don't need to style themselves individually:
- `ElevatedButton` → gold background, white text, height 40, fully rounded
- `TextButton` → white background, gold text
- `InputDecoration` → gold border, grey fill, radius 12
- `AppBar` → `greyDarkest` background, white icons, Nunito semiBold 22 title
- `Card` → grey background, radius 8, shadow
- `ListTile` → gold icons, Helvetica bold title
