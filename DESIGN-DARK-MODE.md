---
name: Serene Tajweed Night
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#d0c5af'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#99907c'
  outline-variant: '#4d4635'
  surface-tint: '#e9c349'
  primary: '#f2ca50'
  on-primary: '#3c2f00'
  primary-container: '#d4af37'
  on-primary-container: '#554300'
  inverse-primary: '#735c00'
  secondary: '#cbc5c2'
  on-secondary: '#32302e'
  secondary-container: '#4b4846'
  on-secondary-container: '#bdb7b4'
  tertiary: '#e4cb9e'
  on-tertiary: '#3d2e0e'
  tertiary-container: '#c7b085'
  on-tertiary-container: '#534321'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffe088'
  primary-fixed-dim: '#e9c349'
  on-primary-fixed: '#241a00'
  on-primary-fixed-variant: '#574500'
  secondary-fixed: '#e7e1de'
  secondary-fixed-dim: '#cbc5c2'
  on-secondary-fixed: '#1d1b19'
  on-secondary-fixed-variant: '#494644'
  tertiary-fixed: '#f9dfb1'
  tertiary-fixed-dim: '#dcc497'
  on-tertiary-fixed: '#261a00'
  on-tertiary-fixed-variant: '#554422'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  headline-lg:
    fontFamily: Noto Serif
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-md:
    fontFamily: Noto Serif
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-reading-arabic:
    fontFamily: Noto Serif
    fontSize: 28px
    fontWeight: '400'
    lineHeight: 56px
    letterSpacing: 0.02em
  body-translation:
    fontFamily: Noto Serif
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Work Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  headline-lg-mobile:
    fontFamily: Noto Serif
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  margin-page: 24px
  gutter-verse: 32px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 40px
---

## Brand & Style

The design system is a high-fidelity dark-mode evolution of traditional manuscript aesthetics. It is designed for deep spiritual focus, scholarly study, and late-night reading sessions. The brand personality is **Serene, Premium, and Academic**. 

We utilize a **Modern Minimalist** style that respects classical Islamic art. The interface disappears to prioritize the sacred text, using subtle golden accents and deep charcoal tones to create an atmosphere of reverence. The emotional response should be one of "Sanctuary"—a quiet, focused space where the user feels no digital eye strain.

## Colors

The palette is built on a foundation of **Obsidian and Gold**. 
- **Primary Gold (#D4AF37):** Used for highlights, active states, and calligraphic flourishes. It must remain legible against the dark background without causing "bloom" or glare.
- **Deep Background (#121212):** A near-black with a 2% warm tint to prevent the coldness of pure OLED black, providing a comfortable canvas for long reading.
- **Surface Tiers (#1E1C1A):** Used for cards and navigation bars to create subtle depth.
- **High-Contrast Text (#FFFFFF):** Reserved specifically for the Arabic script to ensure maximum legibility for Tajweed rules.

## Typography

Typography is the core of this design system. 
- **Arabic Script:** Must be rendered with generous line-height (minimum 1.8x) to accommodate complex diacritics and Tajweed marks. The color should be pure white or a very light cream for maximum contrast.
- **Latin Typography:** **Noto Serif** provides a scholarly, timeless feel that bridges the gap between modern UI and classical publishing.
- **Functional Labels:** **Work Sans** is used for metadata (Juz, Page numbers, Settings) to provide a clear, neutral contrast to the serif reading text.
- **Tajweed Color Coding:** When enabled, use specific desaturated tones (Muted Green, Deep Red, Soft Blue) that remain visible but harmonious within the dark theme.

## Layout & Spacing

The layout follows a **Fluid Content Model** optimized for reading. 
- **The Reading Container:** On tablets and desktops, the reading area should be constrained to a maximum width (768px) to maintain optimal line lengths for the eye.
- **Margins:** Large 24px-32px outer margins create a "frame" effect, mimicking the margins of a physical Mus'haf.
- **Verse Spacing:** Generous vertical rhythm between verses ensures the user doesn't lose their place. 
- **Mobile:** Elements reflow to a single column, but the side margins remain a minimum of 16px to prevent text from touching the screen edges.

## Elevation & Depth

This design system avoids heavy drop shadows in favor of **Tonal Layering** and **Subtle Outlines**.
- **Surface Elevation:** We use progressively lighter shades of charcoal to indicate elevation (e.g., a card is slightly lighter than the background).
- **Golden Glows:** Instead of shadows, active elements (like a selected verse) feature a very soft, low-opacity golden outer glow (0px 0px 12px rgba(212, 175, 55, 0.2)).
- **Decorative Borders:** Use 1px solid lines in Tertiary Gold (#8C7851) at 30% opacity for dividers and frames to maintain the manuscript aesthetic without being visually heavy.

## Shapes

The shape language is **Soft and Precise**. 
- Elements use a 4px (0.25rem) base corner radius. This provides a slight softening of the digital edges while maintaining a disciplined, geometric feel appropriate for a religious/academic tool.
- **Ayah Markers:** Verse numbers are enclosed in perfect circles or "Ayah stars," accented with a 1px golden stroke.
- **Selection States:** When a word or verse is selected, the highlight should have soft, rounded ends rather than sharp corners.

## Components

### Reading Cards
Used for Surah listings. They feature a 1px border on the bottom and a subtle background shift on hover. The Surah name should be in high-contrast white, with metadata (verses/revelation place) in Muted Gold.

### Navigation Bar
A blur-effect (Glassmorphism) bar with 80% opacity on the #121212 background. This allows the text to scroll underneath while maintaining legibility of the title and Juz information.

### Primary Buttons
Ghost-style buttons with a 1px Primary Gold border and Gold text. When active/pressed, they fill with Gold and use Obsidian (#121212) for the text label.

### The Ayah Number
A circular component. In dark mode, the circle should be a subtle fill (#1E1C1A) with a gold stroke. The number itself must be legible at small sizes using Work Sans.

### Input Fields
Darker than the background (#0A0A0A) with a 1px border that turns Primary Gold on focus. Use Noto Serif for the input text to maintain the "writerly" feel.