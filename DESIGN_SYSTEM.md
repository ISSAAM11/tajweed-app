# Design System — Tajweed AI

All design tokens live under `lib/src/app/design/`. Never hardcode colors, sizes, fonts, or asset paths in widgets — always reference the constants below.

The app ships **two themes** — a daytime "Serene Tajweed" light theme and a nighttime "Serene Tajweed Night" dark theme — switched live from `/settings` via `ThemeBloc`. Both share the same gold brand signature but differ in surface palette, mood, and reading ergonomics.

---

## Brand identity

### Light mode — *Serene Tajweed*

**Personality**: Authoritative yet welcoming, designed to evoke spiritual tranquility and intellectual focus. Caters to learners ranging from young students to dedicated adults mastering Quranic recitation.

**Style**: Corporate / Modern with strong tactile influences. A layered card-based architecture prioritizing clarity and legibility. Spiritual heritage is honored through subtle Islamic geometric patterns and a sophisticated palette that feels premium and timeless. **Emotional response: calm, guidance, premium educational quality.**

**Palette foundation — Charcoal & Gold on White**
- **Primary (Charcoal `#272525`)** — top navigation, primary headings, the "grounded frame" of the content
- **Secondary (Gold/Ochre `#D4AF37` → `#F2BE5D`)** — CTAs, active states, progress indicators, decorative icons; adds warmth and signifies value
- **Tertiary (Beige / Cream `#F4E4BC`)** — soft background alternative to pure white, used for secondary cards to reduce eye strain
- **Neutral (White `#FFFFFF` / Off-white `#F9F9F9`)** — the core content background for maximum readability

Decorative patterns sit at 5–10 % opacity so they read as texture, not noise.

### Dark mode — *Serene Tajweed Night*

**Personality**: A high-fidelity evolution of traditional manuscript aesthetics, designed for **deep spiritual focus, scholarly study, and late-night reading**. Brand personality: Serene, Premium, Academic.

**Style**: Modern Minimalist that respects classical Islamic art. The interface disappears so the sacred text dominates, using subtle golden accents on deep charcoal tones. **Emotional response: "Sanctuary"** — a quiet, focused space free of digital eye strain.

**Palette foundation — Obsidian & Gold**
- **Primary Gold (`#D4AF37` / accent `#F2CA50`)** — highlights, active states, calligraphic flourishes; legible against dark backgrounds without bloom or glare
- **Deep Background (`#131313` / `#1A1A1A`)** — near-black with a subtle warm tint; avoids the coldness of pure OLED black for long reading sessions
- **Surface tiers (`#1C1B1B` → `#2A2A2A` → `#353534`)** — progressively lighter charcoal layers indicate elevation tonally (no heavy drop shadows)
- **High-contrast text (`#F5F5F5` / `#FFFFFF`)** — reserved for Arabic script to maximize Tajweed-rule legibility

### Shared brand signatures (preserved across both modes)

| Element | Light | Dark | Rationale |
|---|---|---|---|
| Brand gold | `primary #D4AF37` | `primary #D4AF37` | Same gold in both modes — the most visible brand element |
| AppBar | `greyDarkest #413E40` | `greyDarkest #413E40` | Identical AppBar in both modes for a recognizable brand frame |
| Input focus | Gold border | Gold border | Brand-consistent affordance |
| Quranic Arabic | `primaryLight #E6C866` | `primaryLight #E6C866` | Same gold for sacred text in both modes |

---

## Colors — `AppColors`

The palette is built around **elegant gold** as the brand color. Light mode uses it as an accent on white; dark mode uses it as the focal point against obsidian surfaces.

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

### Dark theme tokens — *Serene Tajweed Night* spec

Used by `AppThemes.dark`. The tiered surfaces map directly to the *Serene Tajweed Night* elevation model: progressively lighter charcoal indicates elevation **tonally** (no heavy drop shadows). The gold brand is preserved with a dark-mode-specific variant for stronger luminance against obsidian.

**Surfaces & text**

| Name | Hex | Use | Spec mapping |
|---|---|---|---|
| `darkScaffold` | `#131313` | Dark mode scaffold background | `surface` / `background` |
| `darkSurfaceContainerLowest` | `#0E0E0E` | Deepest tier — modal backdrops, sunken inputs | `surface-container-lowest` |
| `darkSurfaceContainerLow` | `#1C1B1B` | Subtle tier above scaffold | `surface-container-low` |
| `darkSurface` | `#201F1F` | Cards, dialogs, snackbars | `surface-container` |
| `darkSurfaceVariant` | `#2A2A2A` | Input fills, tooltips, slightly elevated | `surface-container-high` |
| `darkSurfaceContainerHighest` | `#353534` | Most elevated tier — selected rows, hover | `surface-container-highest` |
| `darkSurfaceBright` | `#393939` | Bright accent surface | `surface-bright` |
| `darkTextPrimary` | `#E5E2E1` | Primary body text — warm cream, less eye strain than pure white | `on-surface` |
| `darkTextSecondary` | `#D0C5AF` | Hints, subtitles — warm cream tint | `on-surface-variant` |

**Outlines & brand variants**

| Name | Hex | Use | Spec mapping |
|---|---|---|---|
| `darkOutline` | `#99907C` | Stronger borders, decorative lines | `outline` |
| `darkBorder` | `#4D4635` | Dividers, unfocused input borders | `outline-variant` |
| `darkPrimary` | `#F2CA50` | Dark-mode gold — brighter than light's `#D4AF37` for luminance on obsidian | `primary` |
| `darkOnPrimary` | `#3C2F00` | Text/icon on dark-mode gold | `on-primary` |
| `darkPrimaryContainer` | `#D4AF37` | Light-mode gold reused as the "container" gold in dark | `primary-container` |
| `darkError` | `#FFB4AB` | Softer red for dark surfaces | `error` |
| `darkOnError` | `#690005` | Text/icon on dark error | `on-error` |

### How to consume colors in a widget

Every color reference in a widget falls into one of two buckets. Follow this rule any time you write a new widget or migrate an existing one.

#### Bucket 1 — Brand-locked (same in light and dark)

Call `AppColors.*` directly. These colors are intentionally identical in both modes because they carry the brand signature.

- Gold family: `primary`, `primaryLight`, `primaryDark`, `secondary` (cream gold), `tertiary` (warm brown)
- Brand-locked chrome: `greyDarkest` **when used as AppBar background** (deliberately identical in both modes)
- Status colors: `error`, `success`, `warning`, `info`
- Brand decorations: gradients (`primaryGradient`, etc.), gold-card backgrounds, gold-on-text on cream cards
- Fixed-asset contexts: text painted on top of an asset image with a fixed palette (e.g., Mus'haf paper-texture backgrounds, last-read gold card, dark "header shelf")

```dart
// Brand-locked — stays gold in both modes:
color: AppColors.primary
backgroundColor: AppColors.greyDarkest  // AppBar (brand)
gradient: AppColors.primaryGradient
```

#### Bucket 2 — Theme-reactive (changes with the theme)

Read from `Theme.of(context).colorScheme.*`. These automatically resolve to the right light or dark token.

| What you used to write | What to write now | Resolves to (light → dark) |
|---|---|---|
| `AppColors.scaffold` (screen bg) | `Theme.of(context).colorScheme.surface` | `#FFFFFF` → `#131313` |
| `AppColors.greyBackground` (card / input bg) | `Theme.of(context).colorScheme.surfaceContainer` or `.surfaceContainerHigh` | `#F8F9FA` → `#201F1F` / `#2A2A2A` |
| `AppColors.greyDarkest` *(as body text)* | `Theme.of(context).colorScheme.onSurface` | `#2C2C2C` → `#E5E2E1` |
| `AppColors.greyDark` (body text) | `Theme.of(context).colorScheme.onSurface` | `#2C2C2C` → `#E5E2E1` |
| `AppColors.greyMedium` / `.greyRegular` (hint / secondary text) | `Theme.of(context).colorScheme.onSurfaceVariant` | `#555555` → `#D0C5AF` |
| `AppColors.greyLight` / `.divider` (borders) | `Theme.of(context).colorScheme.outlineVariant` | `#E1E2E5` → `#4D4635` |
| `Colors.grey.shade300` etc. | `Theme.of(context).colorScheme.outlineVariant` | — |

```dart
// Theme-reactive — chain with .withColor() exactly like before:
Text(
  'Last read',
  style: AppFonts.lato
      .withSize(FontSizes.indication)
      .withColor(Theme.of(context).colorScheme.onSurface)  // ← reads from theme
      .medium(),
)

Scaffold(
  backgroundColor: Theme.of(context).colorScheme.surface,  // ← reads from theme
  body: ...,
)

// Pattern: grab the scheme once at the top of build() if you use it multiple times.
@override
Widget build(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    color: scheme.surface,
    decoration: BoxDecoration(border: Border.all(color: scheme.outlineVariant)),
    child: Text('Hi', style: AppFonts.lato.withColor(scheme.onSurface)),
  );
}
```

#### Quick test

After writing a widget, toggle Settings → Appearance → Dark and walk through the screen. If anything stays white when it shouldn't (a "white blast"), it's still hardcoded — find the `AppColors.*` reference and migrate it to the right `colorScheme.*` slot.

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

### Typographic intent

**Light mode** uses a clean, modern sans-serif voice (currently **Lato / Helvetica / Poppins / Nunito**; the design spec targets **Plus Jakarta Sans** as the unifying family). It is friendly, professional, and balanced — generous line heights accommodate both Latin and Arabic comfortably. Arabic scales ~125 % larger than Latin to maintain visual weight and diacritic legibility.

**Dark mode** leans into a **scholarly, manuscript-inspired voice**: the design spec calls for **Noto Serif** as the reading family for Latin (to bridge modern UI and classical publishing) with **Work Sans** for metadata, Juz / page numbers, and settings. Arabic must use a minimum line-height of **1.8×** to accommodate complex diacritics and Tajweed marks, rendered in pure white or very light cream for maximum contrast.

> **Currently implemented**: Lato / Helvetica / Poppins / Nunito for UI, UthmanicHafsV18 for Quran text, SurahNameV4 for Surah glyphs. The Plus Jakarta Sans (light) / Noto Serif + Work Sans (dark) palettes are **design targets** not yet wired into `AppFonts`.

### Tajweed color coding in dark mode

When Tajweed highlighting is enabled in dark mode, the rule colors must remain visible but harmonious with the dark theme — desaturated tones (Muted Green, Deep Red, Soft Blue) rather than the saturated light-mode versions. See the **Tajweed Colors** section below for the current static palette (these are not yet split per theme).

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

## Layout, Spacing, Shapes & Elevation

### Layout intent

**Light mode** uses a **Fixed Grid** centered with a **20 px safety margin** on mobile. Vertical rhythm is strict: cards stack with **16 px gutters**. The top ~20 % of the screen is reserved for a dark primary container with rounded bottom corners — the *"header shelf"* that frames featured progress cards. On tablet/desktop the layout reflows to a 2–3 column grid, with content width capped at **800 px** for optimal educational-text readability.

**Dark mode** uses a **Fluid Content Model** optimized for reading. The reading area is constrained to a **maximum width of 768 px** on tablets/desktops to preserve optimal line lengths. Margins of **24–32 px** create a manuscript-style "frame" — mimicking the margins of a physical Mus'haf. Verse spacing is generous to prevent the reader from losing their place. On mobile, side margins stay at a **minimum of 16 px** so text never touches the screen edges.

### Shapes — same shape grammar, different radii ambitions

Both modes use **rounded, friendly containers** but the design specs target different scales:

| Element | Light spec | Dark spec | In code (`AppMetrics`) |
|---|---|---|---|
| Standard cards | 16 px (1 rem) | 4 px (0.25 rem) — disciplined / geometric | `defaultRadius` 12 |
| Hero / featured cards | 24 px (1.5 rem) | 4 px | — |
| Primary buttons | Pill-shaped (fully rounded) | 4 px ghost-style | `buttons.radius` 50 |
| Inputs / OTP | 8 px | 4 px | `inputs.radius` 12 |
| Ayah markers | — | Perfect circles / 8-pointed Rub el Hizb with 1 px gold stroke | — |

The **Rub el Hizb (8-pointed star)** is used as an icon enclosure for religious/symbolic icons in both modes, with a 2 px stroke.

### Elevation — tonal layering vs. ambient shadows

**Light mode** uses **ambient shadows** to establish hierarchy:
- *Level 1 (Surface)*: white or light beige background
- *Level 2 (Cards)*: pure white with a soft diffused shadow — blur 15 px, opacity 5 %, color charcoal
- *Level 3 (Interactive)*: more pronounced shadow or subtle inner glow on hover/press

The *"header shelf"* uses no shadow — it relies on raw color contrast (charcoal on white) to define depth.

**Dark mode** avoids heavy drop shadows entirely in favor of **tonal layering** and **subtle outlines**:
- *Surface elevation* uses progressively lighter charcoal (cards lighter than scaffold, dialogs lighter than cards)
- *Golden glows* replace shadows on active elements — soft low-opacity gold outer glow `0 0 12 rgba(212, 175, 55, 0.2)`
- *Decorative borders* use 1 px tertiary gold (`#8C7851`) at 30 % opacity for dividers and frames

### Component-level differences

| Component | Light | Dark |
|---|---|---|
| Reading cards | White, soft shadow, gold accent bar on left edge | 1 px bottom border, subtle bg shift on hover, high-contrast white title + muted-gold metadata |
| Navigation bar | Solid charcoal `#272525` with white text | Glassmorphism — 80 % opacity `#121212` with blur |
| Primary button | Pill-shaped gold fill + white text + trailing arrow | Ghost-style 1 px gold border + gold text; fills gold + obsidian text on press |
| Ayah number | Gold circle on white | Subtle dark fill `#1E1C1A` with 1 px gold stroke |
| Input field | Light grey fill `#F8F9FA`, 1 px gold border on focus | Darker than scaffold `#0A0A0A`, 1 px gold border on focus, Noto Serif input text |
| Progress bar | Light grey track, gold fill | Dark track, gold fill |
| Tabs / chips | Text tabs with 3 px charcoal underline for active | 1 px gold border at low opacity |
| Selection state | Soft gold highlight, rounded ends | Soft low-opacity gold glow, rounded ends |

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

> **Theme caveat**: the current Tajweed palette is **shared across light and dark modes**. The dark-mode spec calls for **desaturated, harmonious tones** (Muted Green, Deep Red, Soft Blue) that don't bloom against the obsidian background. A future task will introduce per-theme Tajweed color variants.

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

Configured in `lib/src/app/design/themes/app_themes.dart`. Switched live at runtime by `ThemeBloc` (see `lib/src/app/theme/theme_bloc.dart`) and persisted via `ThemePreferenceService`.

### `AppThemes.light` — *Serene Tajweed*

Material 3 light theme. Gold palette on a white scaffold with a dark `#413E40` AppBar. Defaults applied globally so widgets don't need to style themselves:

- `ElevatedButton` → gold background, white text, height 40, fully rounded
- `TextButton` → white background, gold text
- `InputDecoration` → gold border on focus, grey fill, radius 12
- `AppBar` → `greyDarkest` background, white icons, Nunito semiBold 22 title
- `Card` → grey background, radius 8, soft shadow
- `ListTile` → gold icons, Helvetica bold title

### `AppThemes.dark` — *Serene Tajweed Night*

Material 3 dark theme. `brightness: Brightness.dark`, gold brand preserved, surfaces inverted to the tiered obsidian palette:

- **ColorScheme** — `primary` gold, `surface` `darkScaffold`, `surfaceVariant` `darkSurfaceVariant`, `onSurface` `darkTextPrimary`, `outline` `darkBorder`
- **Scaffold** — `darkScaffold #1A1A1A`
- **AppBar** — `greyDarkest #413E40` retained (brand-signature consistency with light mode), icons in `primaryLight` for contrast on dark surface
- **Card** — `darkSurface #242424`, no shadow (tonal layering instead)
- **Divider** — `darkBorder #3A3A3A`
- **InputDecoration** — fill `darkSurfaceVariant`, border `darkBorder`, **focus border gold** (brand-consistent)
- **Dialog / ListTile / Tooltip / SnackBar / Chip / TextButton** — all wired to dark tokens with gold accents

### Theme switching contract

- The Material widget tree (AppBar, Card, Dialog, Input, Button, etc.) **adapts automatically** when `themeMode` flips.
- Direct widget references to `AppColors.scaffold`, `AppColors.greyDarkest`, etc. **do not adapt** — they are `const`. Widgets that need to react to theme must either read from `Theme.of(context).colorScheme` or use a future `context.colors.*` semantic accessor.
- Always design new widgets so light and dark both look intentional. Toggle Settings → Appearance → Dark to verify before merging.
