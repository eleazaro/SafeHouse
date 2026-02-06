# SafeHouse 🏠

Aplicativo de locação de imóveis com **suporte jurídico integrado** como diferencial. Os usuários navegam por imóveis disponíveis em um feed visual estilo Instagram, filtram por localização/tipo/preço, e têm acesso direto a serviços jurídicos — cobrindo uma lacuna das imobiliárias tradicionais.

**Plataformas**: Android · iOS · Web

## Diferencial

Imobiliárias tradicionais não oferecem suporte jurídico ao inquilino. O SafeHouse resolve isso integrando serviços de revisão de contrato, documentação e resolução de disputas diretamente no app.

## Funcionalidades (v1)

- **Login com Google** — autenticação simples e rápida
- **Feed de imóveis** — experiência visual estilo Instagram com scroll infinito, shimmer loading e animações
- **Detalhe do imóvel** — galeria de fotos, informações completas, amenidades, badge de suporte jurídico
- **Filtros** — por tipo (apartamento, casa, estúdio, comercial), faixa de preço, localização por endereço ou GPS
- **Booking** — seleção de datas com calendário visual
- **Suporte jurídico** — badge e acesso a serviços jurídicos integrados

## Tech Stack

| Camada | Tecnologia |
|--------|-----------|
| Framework | Flutter 3.11+ |
| Linguagem | Dart |
| State Management | Provider + ChangeNotifier |
| Navegação | go_router |
| Tipografia | Google Fonts (Poppins) |
| Backend v1 | Repositório mockado (JSON local) |

## Arquitetura

MVVM + Repository + Services — seguindo o [Flutter App Architecture](https://docs.flutter.dev/app-architecture/guide).

```
lib/
├── config/theme/          # AppColors, AppTheme
├── data/
│   ├── repositories/      # Abstract repos + mock implementations
│   ├── services/          # API/external service wrappers
│   └── models/            # DTOs para serialização
├── domain/models/         # Entidades (Property, User)
├── routing/               # GoRouter config
├── ui/
│   ├── core/widgets/      # Componentes compartilhados
│   ├── splash/            # Splash screen
│   ├── auth/              # Login (Google Sign-In)
│   ├── home/              # Feed principal
│   ├── property_detail/   # Detalhe do imóvel
│   └── booking/           # Reserva de imóvel
└── utils/
```

## Como rodar

```bash
# Instalar dependências
flutter pub get

# Rodar no dispositivo/emulador
flutter run

# Build
flutter build apk       # Android
flutter build ios        # iOS
flutter build web        # Web

# Testes
flutter test

# Lint
dart analyze
```

## Design

- **Tema**: Dark com acento laranja (#FF6B00)
- **UX**: Feed estilo Instagram, scroll infinito, transições hero
- **Detalhes completos**: ver [docs/DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md)

## Roadmap

Fases detalhadas em [docs/V1_TODO.md](docs/V1_TODO.md).

| Fase | Status |
|------|--------|
| 0 — Setup & Fundação | Em andamento |
| 1 — Autenticação (Google) | Pendente |
| 2 — Feed de Imóveis | Pendente |
| 3 — Detalhe do Imóvel | Pendente |
| 4 — Booking | Pendente |
| 5 — Jurídico | Pendente |
| 6 — Filtros Avançados | Pendente |
