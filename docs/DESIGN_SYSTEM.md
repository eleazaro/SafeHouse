# SafeHouse Design System

Este documento define o sistema de design do SafeHouse, baseado no conceito visual aprovado. O padrão de interação é inspirado no feed do Instagram — scroll vertical infinito com cards visuais grandes — para oferecer familiaridade ao usuário.

---

## 1. Paleta de Cores

### Cores Primárias

| Token                | Hex       | Uso                                      |
|----------------------|-----------|------------------------------------------|
| `background`         | `#1A1A1A` | Fundo principal do app (dark)            |
| `surface`            | `#2A2A2A` | Cards, containers, bottom sheets         |
| `surfaceLight`       | `#F5F0EB` | Cards claros, áreas de detalhe           |
| `primary`            | `#FF6B00` | Botões de ação, destaques, CTAs          |
| `primaryVariant`     | `#E55E00` | Hover/pressed state do primary           |
| `onBackground`       | `#FFFFFF` | Texto principal sobre fundo escuro       |
| `onBackgroundSecondary` | `#B0B0B0` | Texto secundário, labels, subtítulos  |
| `onSurface`          | `#FFFFFF` | Texto sobre cards escuros                |
| `onSurfaceLight`     | `#1A1A1A` | Texto sobre cards claros                 |
| `onPrimary`          | `#FFFFFF` | Texto/ícones sobre botões laranja        |
| `calendarSelected`   | `#4CAF50` | Data selecionada no calendário           |
| `calendarToday`      | `#FF6B00` | Data atual no calendário                 |
| `divider`            | `#3A3A3A` | Linhas divisórias                        |
| `shimmer`            | `#333333` | Skeleton loading placeholder             |

### Aplicação por Tela

- **Home Feed**: `background` + cards com `surface`
- **Detalhe do Imóvel**: Parte superior `surfaceLight`, inferior `background`
- **Booking**: `background` com calendário em `surface`

---

## 2. Tipografia

**Família**: `Poppins` (Google Fonts)

| Token          | Weight    | Size | Line Height | Uso                              |
|----------------|-----------|------|-------------|----------------------------------|
| `displayLarge` | Bold 700  | 32sp | 40sp        | Títulos de seção ("Find The Perfect Place") |
| `displayMedium`| Bold 700  | 28sp | 36sp        | Títulos de tela ("Book Summary") |
| `titleLarge`   | SemiBold 600 | 24sp | 32sp     | Nome do imóvel no detalhe        |
| `titleMedium`  | SemiBold 600 | 20sp | 28sp     | Nome do imóvel no card           |
| `bodyLarge`    | Regular 400 | 16sp | 24sp       | Descrições, textos longos        |
| `bodyMedium`   | Regular 400 | 14sp | 20sp       | Informações secundárias          |
| `labelLarge`   | Medium 500 | 14sp | 20sp       | Botões, chips ativos             |
| `labelMedium`  | Medium 500 | 12sp | 16sp       | Chips, badges, labels            |
| `labelSmall`   | Regular 400 | 11sp | 14sp       | Metadados, timestamps            |

---

## 3. Espaçamento

Sistema de 4px base:

| Token  | Valor | Uso                                |
|--------|-------|------------------------------------|
| `xs`   | 4px   | Espaço entre ícone e texto inline  |
| `sm`   | 8px   | Padding interno de chips           |
| `md`   | 12px  | Gap entre elementos de lista       |
| `base` | 16px  | Padding padrão de telas e cards    |
| `lg`   | 20px  | Margem entre seções                |
| `xl`   | 24px  | Espaçamento de headers             |
| `xxl`  | 32px  | Margem superior de telas           |

---

## 4. Bordas e Sombras

| Token               | Valor                    | Uso                        |
|----------------------|--------------------------|----------------------------|
| `radiusSm`           | 8px                     | Chips, badges              |
| `radiusMd`           | 12px                    | Inputs, botões pequenos    |
| `radiusLg`           | 16px                    | Cards de imóvel            |
| `radiusXl`           | 24px                    | Bottom sheets, modais      |
| `radiusCircle`       | 50%                     | Avatares, botões de ação   |
| `cardElevation`      | `0dp` (sem sombra)      | Cards usam bordas/cor      |
| `bottomSheetShadow`  | `0 -4px 20px rgba(0,0,0,0.3)` | Sombra de bottom sheet |

---

## 5. Componentes

### 5.1 SafeHouseAppBar

Barra superior customizada (não usa AppBar padrão do Material).

```
┌──────────────────────────────────────────┐
│  [Avatar]  Hi, {nome}        [🔔]       │
│            Welcome Back                  │
└──────────────────────────────────────────┘
```

- **Avatar**: CircleAvatar 40px com foto do usuário
- **Saudação**: `labelMedium` cinza + `bodyMedium` branco
- **Notificação**: IconButton com sino, 24px, branco
- Fundo: transparente (sobre o `background`)

### 5.2 PropertyCard (Feed Card)

Card principal do feed, inspirado no post do Instagram.

```
┌──────────────────────────────────────────┐
│                                    [🔖]  │
│           [Imagem do Imóvel]             │
│                                          │
│  Lumina Apartment                        │
│  9% brokerage on all deals              │
│                                          │
│  [📞]                      [Book Now ➜] │
└──────────────────────────────────────────┘
```

- **Dimensões**: Largura total da tela - 32px (padding 16px cada lado)
- **Imagem**: Aspect ratio 4:3, `radiusLg`, `BoxFit.cover`
- **Bookmark**: Ícone circular laranja, canto superior direito, 36px
- **Título**: `titleMedium`, branco, max 2 linhas
- **Subtítulo**: `bodyMedium`, cinza (`onBackgroundSecondary`)
- **Botão telefone**: CircleAvatar 44px, borda branca, ícone branco
- **Book Now**: Container com `primary` background, `radiusMd`, `labelLarge` branco
- **Espaço entre cards**: `md` (12px)
- **Animação**: Fade-in ao entrar no viewport (como Instagram)

### 5.3 FilterChips

Linha horizontal scrollável de filtros.

```
[🔖] [Whole list] [Site Visit] [For Sell] [...]
```

- **Chip ativo**: Fundo `primary`, texto `onPrimary`
- **Chip inativo**: Fundo `surface`, borda 1px `divider`, texto `onBackgroundSecondary`
- **Altura**: 36px
- **Padding horizontal**: `sm` (8px) interno, `sm` entre chips
- **Ícone bookmark**: Mesmo estilo de chip mas apenas ícone, 36x36px

### 5.4 PropertyDetailHeader

Seção superior da tela de detalhe.

```
┌──────────────────────────────────────────┐
│  [Avatar]  Hi, {nome}        [🔔]       │
│                          California, USA │
│  Vibe Apartment                          │
│  12% brokerage on all deals             │
│                                          │
│         [Imagem grande do imóvel]        │
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │  Room  [🏠] [🔧] [🚗] [🏊]        │ │
│  │                                     │ │
│  │  Book an Apartment          [📞]    │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  [➜]    [Book Now]              [>>]     │
└──────────────────────────────────────────┘
```

- **Card inferior**: Fundo `surfaceLight` com `radiusXl` no topo
- **Room icons**: Circulares 40px, fundo `surface`, ícone branco
- **Texto "Book an Apartment"**: `titleMedium`, `onSurfaceLight`

### 5.5 BookingCalendar

Calendário de seleção de datas.

```
┌──────────────────────────────────────────┐
│  December 2025              [<]  [>]     │
│  Sun Mon Tue Wed Thu Fri Sat             │
│                  01  02  03  04  05  06  │
│   07  08  09  10  11  12  13             │
│   14  15 [16] 17 (18) 19  20            │
│   21  22  23  24  25  26  27             │
│   28  29  30  31                         │
├──────────────────────────────────────────┤
│  Pick-up-Date          Return Date       │
│  📅 15 Dec 2025 ▾      📅 01 Jan 2026 ▾ │
├──────────────────────────────────────────┤
│  [😊]        [Book Now]           [📋]  │
└──────────────────────────────────────────┘
```

- **Header mês**: `titleMedium`, branco, com setas de navegação
- **Dias da semana**: `labelSmall`, `onBackgroundSecondary`
- **Dia normal**: `bodyMedium`, branco
- **Dia selecionado** `[16]`: Círculo com borda `calendarSelected` (verde)
- **Dia atual** `(18)`: Círculo preenchido `calendarToday` (laranja)
- **Date pickers**: Container `surface`, ícone calendário + texto + chevron
- **Botão Book Now**: Full-width, `primary`, `radiusMd`, 48px altura

### 5.6 ActionButton (FAB circular)

Botões de ação circulares.

- **Tamanho**: 44-56px
- **Fundo**: `primary` (laranja)
- **Ícone**: branco, 24px
- **Variantes**: Telefone, seta para frente, bookmark
- **Sombra**: Sutil, `rgba(255, 107, 0, 0.3)`

### 5.7 BottomNavigationBar

```
┌──────────────────────────────────────────┐
│  [🏠]    [🔍]    [❤️]    [👤]           │
└──────────────────────────────────────────┘
```

- **Fundo**: `surface` com borda superior `divider`
- **Ícone ativo**: `primary`
- **Ícone inativo**: `onBackgroundSecondary`
- **Sem labels** (apenas ícones, estilo limpo)

---

## 6. Padrões de Interação (Instagram-like)

### Feed Scroll
- **Scroll vertical infinito** com lazy loading
- Cards aparecem com **fade-in animation** (200ms, curve: easeOut)
- **Pull-to-refresh** com indicador laranja
- Scroll position é preservada ao voltar da tela de detalhe

### Skeleton Loading
- Ao carregar dados, mostrar placeholders com shimmer effect
- Cor do shimmer: `shimmer` (#333333) → `surface` (#2A2A2A)
- Formato segue o layout exato do PropertyCard

### Transições de Tela
- **Card → Detalhe**: Hero animation na imagem do imóvel
- **Detalhe → Booking**: Slide-up (bottom sheet style)
- **Duração padrão**: 300ms
- **Curve padrão**: `Curves.easeInOut`

### Feedback Tátil
- Botões: `HapticFeedback.lightImpact` no tap
- Bookmark: `HapticFeedback.mediumImpact` + animação de escala (pulse)
- Pull-to-refresh: `HapticFeedback.lightImpact` ao ativar

---

## 7. Ícones

- **Fonte**: Material Icons (padrão Flutter)
- **Tamanho padrão**: 24px
- **Cor sobre dark**: branco
- **Cor sobre light**: `onSurfaceLight`
- **Cor de ação**: `primary`

Ícones principais:
| Contexto              | Ícone Material            |
|-----------------------|---------------------------|
| Notificação           | `Icons.notifications_outlined` |
| Bookmark (salvar)     | `Icons.bookmark_border` / `Icons.bookmark` |
| Telefone              | `Icons.phone_outlined`    |
| Localização           | `Icons.location_on_outlined` |
| Filtro                | `Icons.tune`              |
| Voltar                | `Icons.arrow_back_ios`    |
| Casa                  | `Icons.home_outlined`     |
| Busca                 | `Icons.search`            |
| Favoritos             | `Icons.favorite_outline`  |
| Perfil                | `Icons.person_outline`    |
| Calendário            | `Icons.calendar_today`    |
| Jurídico              | `Icons.gavel`             |
| Avançar               | `Icons.arrow_forward`     |

---

## 8. Responsividade

| Breakpoint    | Largura       | Layout                          |
|---------------|---------------|---------------------------------|
| Mobile        | < 600px       | 1 coluna, cards full-width      |
| Tablet        | 600 - 1200px  | 2 colunas de cards (grid)       |
| Desktop/Web   | > 1200px      | 3 colunas + sidebar de filtros  |

### Regras:
- Mobile: Feed vertical como Instagram, bottom nav bar
- Tablet: Grid 2 colunas, bottom nav bar
- Web: Grid 3 colunas, sidebar lateral para filtros, top nav bar

---

## 9. Implementação Flutter

### Tokens como constantes Dart

```dart
// app_colors.dart
class AppColors {
  static const background = Color(0xFF1A1A1A);
  static const surface = Color(0xFF2A2A2A);
  static const surfaceLight = Color(0xFFF5F0EB);
  static const primary = Color(0xFFFF6B00);
  static const primaryVariant = Color(0xFFE55E00);
  static const onBackground = Color(0xFFFFFFFF);
  static const onBackgroundSecondary = Color(0xFFB0B0B0);
  static const onSurface = Color(0xFFFFFFFF);
  static const onSurfaceLight = Color(0xFF1A1A1A);
  static const onPrimary = Color(0xFFFFFFFF);
  static const calendarSelected = Color(0xFF4CAF50);
  static const calendarToday = Color(0xFFFF6B00);
  static const divider = Color(0xFF3A3A3A);
  static const shimmer = Color(0xFF333333);
}
```

### ThemeData

Usar `ThemeData.dark()` como base e sobrescrever com os tokens acima. Configurar `colorScheme`, `textTheme` (com Poppins), `cardTheme`, `chipTheme`, `appBarTheme`, e `bottomNavigationBarTheme` conforme os tokens definidos.
