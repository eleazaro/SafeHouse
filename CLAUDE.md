# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SafeHouse is a Flutter real estate app with integrated legal services. Users browse rental properties in an Instagram-like feed, filter by location/type/price, and access legal support. Platforms: Android, iOS, Web.

## Common Commands

- **Run**: `flutter run`
- **Build**: `flutter build apk` / `flutter build ios` / `flutter build web`
- **Test all**: `flutter test`
- **Test single file**: `flutter test test/<path_to_test>.dart`
- **Lint/Analyze**: `dart analyze`
- **Format**: `dart format .`
- **Get dependencies**: `flutter pub get`

## Architecture

Follows [Flutter App Architecture](https://docs.flutter.dev/app-architecture/guide) — MVVM + Repository + Services pattern.

### Layers

- **UI Layer** (`lib/ui/`): Organized by feature. Each feature has `widgets/` (Views) and `view_models/` (ChangeNotifier). Shared widgets in `ui/core/widgets/`.
- **Domain Layer** (`lib/domain/models/`): Pure data classes shared across layers.
- **Data Layer** (`lib/data/`): `repositories/` (source of truth, abstract + mock impl), `services/` (API wrappers), `models/` (DTOs).

### Key Conventions

- **1 View : 1 ViewModel** — each screen has its own ViewModel (ChangeNotifier)
- **Repositories are abstract** — `MockPropertyRepository` implements `PropertyRepository` for v1; swap for real backend later
- **State management**: `provider` package for DI and ChangeNotifier listening
- **Routing**: `go_router` with declarative routes in `lib/routing/app_router.dart`
- **Theme**: Dark theme with orange accent (`#FF6B00`). All color tokens in `lib/config/theme/app_colors.dart`, ThemeData in `app_theme.dart`
- **Typography**: Poppins via `google_fonts`

### Folder Structure

```
lib/
├── config/theme/          # AppColors, AppTheme
├── data/
│   ├── repositories/      # Abstract repos + mock implementations
│   ├── services/          # API/external service wrappers
│   └── models/            # DTOs for serialization
├── domain/models/         # Core domain entities (Property, User)
├── routing/               # GoRouter config
├── ui/
│   ├── core/widgets/      # Shared components (PropertyCard, FilterChips, etc.)
│   ├── splash/widgets/
│   ├── auth/              # view_models/ + widgets/
│   ├── home/              # view_models/ + widgets/
│   ├── property_detail/   # view_models/ + widgets/
│   └── booking/           # view_models/ + widgets/
└── utils/
```

## Design System

Full design system documented in `docs/DESIGN_SYSTEM.md`. Key points:
- Dark theme, Instagram-like feed UX
- Color tokens: background `#1A1A1A`, surface `#2A2A2A`, primary `#FF6B00`
- Components: PropertyCard, FilterChips, BookingCalendar, SafeHouseAppBar

## V1 Roadmap

Detailed implementation phases in `docs/V1_TODO.md`.
