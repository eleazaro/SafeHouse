# SafeHouse v1 — Roadmap & TODO

## Visão do Produto

SafeHouse é um aplicativo de imobiliária com diferencial jurídico integrado. O cliente navega por imóveis disponíveis para locação em um feed visual (estilo Instagram), filtra por localização e preferências, e tem acesso direto a serviços jurídicos — cobrindo uma lacuna das imobiliárias tradicionais.

**Plataformas**: Android + iOS + Web
**Arquitetura**: Flutter App Architecture (MVVM + Repository + Services)
**Backend v1**: Repositório mockado (sem backend real)

---

## Fase 0 — Setup & Fundação

> Estrutura do projeto, tema e navegação base.

- [ ] Criar projeto Flutter com suporte Android, iOS e Web
- [ ] Configurar estrutura de pastas seguindo Flutter App Architecture
  ```
  lib/
  ├── config/theme/
  ├── data/repositories/, services/, models/
  ├── domain/models/
  ├── routing/
  ├── ui/core/widgets/, splash/, auth/, home/, property_detail/, booking/
  ├── utils/
  └── main.dart
  ```
- [ ] Configurar `pubspec.yaml` com dependências iniciais:
  - `provider` (DI e state management)
  - `go_router` (navegação declarativa)
  - `google_fonts` (Poppins)
  - `google_sign_in` (autenticação)
  - `cached_network_image` (cache de imagens)
  - `shimmer` (skeleton loading)
- [ ] Implementar `AppColors` e `AppTheme` conforme Design System
- [ ] Criar Splash Screen (imagem estática da logo, transição para login/home)
- [ ] Configurar `GoRouter` com rotas: splash → login → home → detalhe → booking
- [ ] Configurar múltiplos entry points: `main.dart`, `main_development.dart`

---

## Fase 1 — Autenticação

> Login via Google com fluxo simples.

- [ ] Criar `User` (domain model)
  ```dart
  class User {
    final String id;
    final String name;
    final String email;
    final String? photoUrl;
  }
  ```
- [ ] Criar `AuthService` — wrapper do `google_sign_in`
- [ ] Criar `AuthRepository` — gerencia estado de autenticação
  - Mock: login sempre sucede com usuário fake
  - Real: delega para `AuthService`
- [ ] Criar `AuthViewModel` (ChangeNotifier)
  - Estado: `isAuthenticated`, `currentUser`, `isLoading`
  - Commands: `signInWithGoogle()`, `signOut()`
- [ ] Criar `LoginScreen`
  - Logo SafeHouse centralizada
  - Botão "Continuar com Google" (estilo Material, cores do Design System)
  - Fundo `background` (#1A1A1A)
- [ ] Configurar guard de autenticação no router (redireciona para login se não autenticado)

---

## Fase 2 — Feed de Imóveis (Home)

> Tela principal com listagem de imóveis estilo feed do Instagram.

- [ ] Criar `Property` (domain model)
  ```dart
  class Property {
    final String id;
    final String title;
    final String address;
    final String city;
    final String state;
    final double latitude;
    final double longitude;
    final double rentPrice;
    final PropertyType type; // apartment, house, studio, commercial
    final double brokeragePercent;
    final List<String> imageUrls;
    final int bedrooms;
    final int bathrooms;
    final double areaSqm;
    final String description;
    final bool hasLegalSupport; // diferencial SafeHouse
    final List<String> amenities;
  }
  ```
- [ ] Criar `PropertyRepository` (mock)
  - Lista de 15-20 imóveis fake com dados realistas
  - Métodos: `getProperties()`, `getPropertyById()`, `getFilteredProperties()`
  - Simular delay de 500-1000ms para testar loading states
- [ ] Criar `HomeViewModel` (ChangeNotifier)
  - Estado: `properties`, `isLoading`, `activeFilters`, `hasError`
  - Commands: `loadProperties()`, `applyFilter()`, `clearFilters()`, `refresh()`
  - Paginação: carregar 10 por vez (scroll infinito)
- [ ] Criar `SafeHouseAppBar` widget
  - Avatar do usuário + saudação + ícone de notificação
- [ ] Criar `FilterChips` widget
  - Scroll horizontal
  - Filtros: Todos, Apartamento, Casa, Estúdio, Comercial
  - Estado ativo/inativo com cores do Design System
- [ ] Criar `PropertyCard` widget
  - Imagem com aspect ratio 4:3
  - Bookmark icon (toggle)
  - Título + info de brokerage
  - Botões de telefone e "Book Now"
  - Hero animation na imagem (para transição ao detalhe)
- [ ] Criar `HomeScreen`
  - `SafeHouseAppBar` no topo
  - Título "Find The Perfect Place"
  - `FilterChips` horizontal
  - `ListView.builder` com `PropertyCard` (scroll infinito)
  - Pull-to-refresh
  - Skeleton loading (shimmer) enquanto carrega
  - Fade-in animation nos cards
- [ ] Implementar `BottomNavigationBar` (Home, Busca, Favoritos, Perfil)

---

## Fase 3 — Detalhe do Imóvel

> Tela completa de informações do imóvel.

- [ ] Criar `PropertyDetailViewModel` (ChangeNotifier)
  - Estado: `property`, `isLoading`, `isBookmarked`
  - Commands: `loadProperty(id)`, `toggleBookmark()`
- [ ] Criar `PropertyDetailScreen`
  - Hero image com transição do card
  - Informações: título, localização, preço, área, quartos, banheiros
  - Badge de brokerage %
  - Galeria de fotos (horizontal scroll)
  - Seção de amenidades (ícones + labels)
  - Seção "Suporte Jurídico" — badge indicando que o imóvel tem cobertura legal SafeHouse
  - Seletor de tipo de quarto (Room icons)
  - Botões: Ligar, Book Now
  - Bottom bar com "Book an Apartment"
- [ ] Transição: slide-up ou hero animation vindo do feed

---

## Fase 4 — Booking (Reserva)

> Tela de resumo e seleção de datas.

- [ ] Criar `Booking` (domain model)
  ```dart
  class Booking {
    final String id;
    final String propertyId;
    final String userId;
    final DateTime checkIn;
    final DateTime checkOut;
    final BookingStatus status; // pending, confirmed, cancelled
  }
  ```
- [ ] Criar `BookingRepository` (mock)
  - Métodos: `createBooking()`, `getUserBookings()`
  - Salvar em memória
- [ ] Criar `BookingViewModel` (ChangeNotifier)
  - Estado: `selectedCheckIn`, `selectedCheckOut`, `isConfirming`
  - Commands: `selectDates()`, `confirmBooking()`
- [ ] Criar `BookingCalendar` widget customizado
  - Calendário mensal com navegação
  - Seleção de range de datas (check-in/check-out)
  - Cores: verde para selecionado, laranja para hoje
- [ ] Criar `BookingSummaryScreen`
  - Título "Book Summary"
  - Calendário
  - Pick-up Date e Return Date (seletores)
  - Botão "Book Now" (full-width, laranja)
  - Ícones de ação na bottom bar

---

## Fase 5 — Jurídico (Diferencial)

> Placeholder para serviços jurídicos integrados.

- [ ] Criar `LegalService` (domain model)
  ```dart
  class LegalService {
    final String id;
    final String title;
    final String description;
    final LegalServiceType type; // contract_review, dispute, documentation
  }
  ```
- [ ] Criar `LegalScreen` (placeholder)
  - Lista de serviços jurídicos disponíveis
  - Cards com ícone `gavel`, título e descrição
  - Botão "Solicitar" (disabled na v1, com label "Em breve")
- [ ] Adicionar badge "Proteção Jurídica SafeHouse" no `PropertyDetailScreen`
- [ ] Adicionar item no `BottomNavigationBar` ou acessível via perfil

---

## Fase 6 — Filtros Avançados

> Sistema completo de filtragem de imóveis.

- [ ] Criar `PropertyFilter` (domain model)
  ```dart
  class PropertyFilter {
    final String? address;
    final double? latitude;
    final double? longitude;
    final double? radiusKm;
    final PropertyType? type;
    final double? minRent;
    final double? maxRent;
    final int? minBedrooms;
  }
  ```
- [ ] Criar `FilterBottomSheet` widget
  - Filtro por endereço (text input com autocomplete)
  - Filtro por "Minha Localização" + slider de range em KM
  - Filtro por tipo de imóvel (chips de seleção múltipla)
  - Filtro por faixa de valor (range slider)
  - Botão "Aplicar Filtros" + "Limpar"
- [ ] Integrar filtros com `HomeViewModel`
  - `applyFilter(PropertyFilter)` re-filtra a lista
  - Indicador visual de filtros ativos na `HomeScreen`
- [ ] Usar `geolocator` package para obter localização do dispositivo

---

## Dependências do pubspec.yaml (v1)

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.0
  go_router: ^14.0.0
  google_fonts: ^6.2.0
  google_sign_in: ^6.2.0
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

---

## Critérios de Aceite da v1

1. Usuário consegue fazer login com Google
2. Feed mostra imóveis com scroll infinito e skeleton loading
3. Filtros básicos funcionam (tipo de imóvel, faixa de preço)
4. Tela de detalhe mostra todas as informações do imóvel
5. Calendário de booking permite selecionar datas
6. Seção jurídica está visível como placeholder
7. App funciona em Android, iOS e Web
8. Design consistente com o Design System definido
9. Transições e animações fluidas (hero, fade-in, pull-to-refresh)
10. `flutter analyze` sem warnings
