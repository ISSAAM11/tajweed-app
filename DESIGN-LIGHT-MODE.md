---
name: Serene Tajweed
colors:
  surface: '#f9f9f9'
  surface-dim: '#dadada'
  surface-bright: '#f9f9f9'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f4'
  surface-container: '#eeeeee'
  surface-container-high: '#e8e8e8'
  surface-container-highest: '#e2e2e2'
  on-surface: '#1a1c1c'
  on-surface-variant: '#4d4545'
  inverse-surface: '#2f3131'
  inverse-on-surface: '#f0f1f1'
  outline: '#7e7575'
  outline-variant: '#d0c4c4'
  surface-tint: '#615d5d'
  primary: '#272525'
  on-primary: '#ffffff'
  primary-container: '#3d3a3a'
  on-primary-container: '#a9a4a3'
  inverse-primary: '#cbc5c5'
  secondary: '#7c5800'
  on-secondary: '#ffffff'
  secondary-container: '#ffc967'
  on-secondary-container: '#765300'
  tertiary: '#26251f'
  on-tertiary: '#ffffff'
  tertiary-container: '#3c3b34'
  on-tertiary-container: '#a8a59b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e7e1e1'
  primary-fixed-dim: '#cbc5c5'
  on-primary-fixed: '#1d1b1b'
  on-primary-fixed-variant: '#494646'
  secondary-fixed: '#ffdea8'
  secondary-fixed-dim: '#f2be5d'
  on-secondary-fixed: '#271900'
  on-secondary-fixed-variant: '#5e4200'
  tertiary-fixed: '#e6e2d8'
  tertiary-fixed-dim: '#cac6bc'
  on-tertiary-fixed: '#1c1c15'
  on-tertiary-fixed-variant: '#48473f'
  background: '#f9f9f9'
  on-background: '#1a1c1c'
  surface-variant: '#e2e2e2'
typography:
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-page: 20px
  gutter-card: 16px
  padding-internal: 16px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 24px
---

## Brand & Style
The brand personality is authoritative yet welcoming, designed to evoke a sense of spiritual tranquility and intellectual focus. It caters to a diverse audience ranging from young learners to dedicated adults seeking to master Quranic recitation.

The design style is **Corporate / Modern** with strong **Tactile** influences. It utilizes a layered card-based architecture that prioritizes clarity and legibility. Spiritual heritage is honored through subtle Islamic geometric patterns and a sophisticated color palette that feels both premium and timeless. The overall emotional response is one of calm, guidance, and premium educational quality.

## Colors
The palette is built on a foundation of high-contrast neutrals and warm metallic accents:
- **Primary (Charcoal):** Used for top navigation bars and primary headings to provide a solid, grounded frame for the content.
- **Secondary (Gold/Ochre):** Reserved for call-to-action buttons, active states, progress indicators, and decorative icons. It adds warmth and signifies value.
- **Tertiary (Beige/Cream):** A soft background alternative to pure white, used for secondary cards or background sections to reduce eye strain.
- **Neutral (White):** The core background for content cards, ensuring maximum readability and a clean aesthetic.

Decorative patterns should use a very low-contrast version of the secondary or tertiary color (e.g., 5-10% opacity) to remain unobtrusive.

## Typography
The system uses **Plus Jakarta Sans** for its modern, friendly, yet professional character. The typography is balanced with generous line heights to accommodate both English and Arabic script comfortably. 

For Arabic text, ensure the font scales appropriately—often requiring a 125% increase in size relative to English to maintain visual weight and legibility of diacritics (Harakat). Headers in the charcoal navigation area should always be white for maximum contrast.

## Layout & Spacing
This design system utilizes a **Fixed Grid** model for mobile devices, centered with a 20px safety margin on either side. 

- **Vertical Rhythm:** Elements follow a strict vertical stack. Cards are separated by 16px to maintain individual identity while appearing as part of a cohesive list.
- **Header Structure:** The top 20% of the screen is reserved for a dark primary container with rounded bottom corners, which acts as a "shelf" for the featured progress card.
- **Responsive Reflow:** On tablet and desktop, the layout should transition to a multi-column grid (2 or 3 columns) for cards, while keeping the central content width capped at 800px for optimal readability of educational text.

## Elevation & Depth
Hierarchy is established through **Ambient Shadows** and tonal layering:
- **Level 1 (Surface):** The main background (White or Light Beige).
- **Level 2 (Cards):** Pure white surfaces with a very soft, diffused shadow (Blur: 15px, Opacity: 5%, Color: Charcoal) to create a slight lift.
- **Level 3 (Interactive):** Buttons and active state cards use a more pronounced shadow or a subtle inner glow to invite interaction.

The "Header Shelf" uses no shadow but relies on color contrast (Charcoal against White) to define depth. Islamic geometric patterns should be placed on the lowest layer (Level 1) to provide texture without competing with content.

## Shapes
The shape language is defined by **Rounded** containers that feel soft and approachable.
- **Standard Cards:** 16px (1rem) corner radius.
- **Featured/Hero Cards:** 24px (1.5rem) corner radius to emphasize their importance.
- **Buttons:** Fully rounded (pill-shaped) for primary actions, while secondary inputs use the standard 8px (0.5rem) radius.
- **Icon Enclosures:** Use 8-pointed star polygons (Rub el Hizb) for religious or symbolic icons, maintaining a 2px stroke weight.

## Components
- **Buttons:** Primary buttons are pill-shaped with a gold gradient or solid gold fill and white text. Include a small trailing arrow icon for "Continue" or "Next" actions.
- **Cards:** Content is housed in cards with 16px internal padding. Lists of items (like Ahkam) should feature a 4px vertical accent bar on the left edge in the secondary gold color.
- **Chips/Tabs:** Use simple text-based tabs with a thick 3px underline in charcoal for the active state. Unselected tabs should be in a muted grey.
- **Input Fields (OTP):** Verification boxes should be square with a 1px gold border and rounded corners (8px).
- **Progress Indicators:** Horizontal bars should use a light grey track with a gold fill.
- **Audio Player:** A specialized card featuring a waveform visualization in gold and a circular play button with a high-contrast charcoal icon.