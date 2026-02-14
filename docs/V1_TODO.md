# SafeHouse v1 — Roadmap & TODO

## Visão do Produto

SafeHouse é um **sistema automatizado e seguro para locação de imóveis** com motor jurídico integrado. Não é um marketplace — é uma plataforma que elimina a dor de cabeça do locatário e do proprietário, automatizando desde a busca até o encerramento do contrato, com proteção jurídica em cada etapa.

**Diferencial**: O Gui (advogado) é o motor jurídico. O app integra serviços legais diretamente no fluxo de locação — cobrança, contrato, vistoria, despejo — tudo dentro do sistema.

**Plataformas**: Android + iOS + Web
**Arquitetura**: Flutter App Architecture (MVVM + Repository + Services)
**Backend v1**: Repositório mockado → migrar para Firebase/Supabase no v2

---

## Dois perfis de usuário

| Perfil | Fluxo |
|--------|-------|
| **Locatário** | Busca imóvel → Aceita termos → Reserva → Paga → Mora → Encerra |
| **Proprietário** | Cadastra imóvel → Aprova vistoria → Acompanha pagamento → Encerra contrato |

## State Machine do Contrato

```
ANÚNCIO → RESERVA → CONTRATO_ASSINADO → ENTREGA_CHAVES → LOCACAO_ATIVA → ENCERRAMENTO → NOVA_LOCACAO
                                                              ↓ (condicional)
                                                         INADIMPLENTE
```

Eventos automáticos (v2+): pagamento atrasou, vistoria recusada, saída solicitada.

---

## Fase 0 — Setup & Fundação ✅

> Estrutura do projeto, tema e navegação base.

- [x] Criar projeto Flutter com suporte Android, iOS e Web
- [x] Configurar estrutura de pastas (Flutter App Architecture)
- [x] Configurar `pubspec.yaml` com dependências iniciais
- [x] Implementar `AppColors` e `AppTheme` conforme Design System
- [x] Criar Splash Screen com logo
- [x] Configurar `GoRouter` com rotas e auth guard
- [x] Criar `AppStrings` — strings centralizadas (sem hardcode)

---

## Fase 1 — Autenticação ✅

> Login via Google com fluxo simples.

- [x] Criar `User` (domain model) com id, name, email, photoUrl
- [x] Criar `AuthService` — wrapper do `google_sign_in`
- [x] Criar `AuthRepository` (abstract + MockAuthRepository + GoogleAuthRepository)
- [x] Criar `AuthViewModel` (ChangeNotifier)
- [x] Criar `LoginScreen` com logo + botão Google
- [x] Configurar guard de autenticação no router

---

## Fase 2 — Feed de Imóveis (Home) ✅

> Tela principal com listagem estilo Instagram.

- [x] Criar `Property` (domain model) com todos os campos
- [x] Criar `PropertyRepository` (mock com 12 imóveis)
- [x] Criar `HomeViewModel` (paginação, filtros, scroll infinito)
- [x] Criar `SafeHouseAppBar` (avatar + saudação + notificação)
- [x] Criar `FilterChipsBar` (Todos, Apartamento, Casa, Estúdio, Comercial)
- [x] Criar `PropertyCard` (imagem 4:3, bookmark, hero animation, fade-in)
- [x] Criar `PropertyCardShimmer` (skeleton loading)
- [x] Implementar `HomeScreen` completa com RefreshIndicator
- [x] Implementar `BottomNavigationBar` (Início, Busca, Favoritos, Perfil)

---

## Fase 3 — Detalhe do Imóvel ✅

> Tela completa de informações do imóvel.

- [x] Criar `PropertyDetailViewModel` (ChangeNotifier)
- [x] Criar `PropertyDetailScreen` com hero image, stats, amenidades
- [x] Badge "Proteção Jurídica SafeHouse"
- [x] Animações staggered fade-in nas seções
- [x] Botão "Alugar" no bottom bar

---

## Fase 4 — Modelo de Domínio do Contrato 🔲

> Base de dados para o fluxo de locação. Sem UI complexa ainda, mas o modelo precisa existir para o app evoluir.

- [ ] Evoluir `User` — adicionar `UserRole` (locatario, proprietario)
  ```dart
  enum UserRole { locatario, proprietario }
  class User {
    // ... campos existentes
    final UserRole role;
    final String? cpf;
    final String? phone;
  }
  ```

- [ ] Criar `Contract` (domain model) — state machine
  ```dart
  enum ContractStatus {
    anuncio,
    reserva,
    contratoAssinado,
    entregaChaves,
    locacaoAtiva,
    inadimplente,
    encerramento,
  }

  class Contract {
    final String id;
    final String propertyId;
    final String tenantId;      // locatário
    final String ownerId;       // proprietário
    final ContractStatus status;
    final DateTime startDate;
    final DateTime endDate;
    final double monthlyRent;
    final double deposit;       // caução
    final DateTime createdAt;
  }
  ```

- [ ] Criar `ContractRepository` (abstract + mock)
  - `createContract(Contract)`
  - `getContractsByUser(userId)`
  - `updateStatus(contractId, ContractStatus)`

- [ ] Adicionar campo `ownerId` e `status` (disponivel, reservado, alugado) ao `Property`

---

## Fase 5 — Fluxo de Locação (Locatário) 🔲

> Caminho do usuário: ver imóvel → aceitar termos → confirmar reserva.

- [ ] Criar `RentalTermsScreen` — tela de termos de locação
  - Texto dos termos (scrollable)
  - Checkbox "Li e aceito os termos de locação"
  - Botão "Confirmar e Reservar"
  - Termos redigidos pelo Gui (advogado)

- [ ] Criar `ReservationConfirmScreen` — confirmação da reserva
  - Resumo do imóvel (foto, título, preço)
  - Dados do contrato (início, valor mensal, caução)
  - Indicador de próximos passos (pagamento → contrato → chaves)
  - Botão "Confirmar Reserva"
  - Estado de sucesso: "Reserva confirmada! Entraremos em contato."

- [ ] Criar `RentalViewModel` (ChangeNotifier)
  - Estado: `termsAccepted`, `isConfirming`, `reservationComplete`
  - Commands: `acceptTerms()`, `confirmReservation(propertyId)`

- [ ] Atualizar fluxo no `PropertyDetailScreen`
  - Botão "Alugar" → navega para `RentalTermsScreen`

- [ ] Adicionar rotas: `/property/:id/terms`, `/property/:id/confirm`

---

## Fase 6 — Filtros Avançados 🔲

> Busca por endereço, localização GPS e faixa de preço.

- [ ] Criar `FilterBottomSheet` widget
  - Campo de busca por endereço (text input)
  - Filtro por tipo de imóvel (chips de seleção múltipla)
  - Filtro por faixa de valor (range slider R$ min — R$ max)
  - Botão "Aplicar Filtros" + "Limpar"

- [ ] Integrar filtros com `HomeViewModel`
  - `applyAdvancedFilter(PropertyFilter)` usa `getFilteredProperties`
  - Indicador visual de filtros ativos na `HomeScreen`

- [ ] Botão de filtro no `SafeHouseAppBar` ou na aba "Busca"

> **GPS (v2)**: usar `geolocator` para "Minha Localização" + slider de raio em KM. Depende de permissões e é mais complexo — deixar para v2.

---

## Fase 7 — Tela do Proprietário (Básica) 🔲

> Visão mínima do proprietário. Apenas visualização, sem cadastro de imóvel (v1 é mock).

- [ ] Criar `OwnerDashboardScreen`
  - Lista dos seus imóveis com status (disponível, reservado, alugado)
  - Card simplificado com foto, título, status, valor

- [ ] Criar `OwnerDashboardViewModel`
  - `getOwnerProperties(ownerId)`

- [ ] Permitir troca de perfil (locatário ↔ proprietário) na tela de Perfil

> **Cadastro de imóvel pelo proprietário (v2)**: formulário completo com fotos, endereço, preço. Requer backend real com upload de imagens.

---

## Fase 8 — Perfil e Configurações 🔲

> Tela do perfil do usuário.

- [ ] Criar `ProfileScreen`
  - Avatar, nome, email
  - Tipo de perfil (Locatário / Proprietário)
  - Meus contratos (lista com status)
  - Botão de logout
  - Versão do app

- [ ] Conectar aba "Perfil" do BottomNavigationBar

---

## O que NÃO entra na v1 (visão do Gui para v2/v3)

| Feature | Por quê não agora | Quando |
|---------|-------------------|--------|
| Pagamento (Pix/cartão) | Precisa de gateway + backend | v2 |
| Contrato digital com assinatura | Precisa de integração (Clicksign/DocuSign) | v2 |
| Vistoria com fotos | Precisa de backend com upload | v2 |
| Cobrança automatizada | Precisa de gateway de pagamento | v2 |
| Motor jurídico (inadimplência → execução → despejo) | Backend + integração com escritório | v3 |
| Seguro integrado | Parceria com seguradora | v3 |
| Troca de imóvel durante locação | Feature avançada | v3 |
| Notificações push de eventos | Firebase Cloud Messaging | v2 |
| Agendamento de mudança | Parceria com transportadora | v3+ |
| Banner / Propaganda | Precisa de conteúdo e parceiros | v2 |

---

## Dependências do pubspec.yaml (v1)

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  go_router: ^14.8.1
  google_fonts: ^6.2.1
  google_sign_in: ^6.2.0
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0
  intl: ^0.20.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

---

## Critérios de Aceite da v1

1. ✅ Usuário faz login com Google
2. ✅ Feed mostra imóveis com scroll infinito e skeleton loading
3. ✅ Filtros básicos por tipo de imóvel funcionam
4. ✅ Tela de detalhe mostra todas as informações + badge jurídico
5. 🔲 Fluxo de locação: aceitar termos → confirmar reserva
6. 🔲 Modelo de contrato com state machine implementado
7. 🔲 Filtros avançados (endereço, preço)
8. 🔲 Tela de perfil com logout e informações
9. ✅ Design consistente com Design System (dark + laranja)
10. ✅ Transições e animações fluidas
11. ✅ Todas as strings em português centralizadas
12. ✅ `dart analyze` sem warnings
