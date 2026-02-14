/// Strings centralizadas do SafeHouse.
/// Todas as strings de UI ficam aqui para facilitar
/// manutenção e futura internacionalização.
class AppStrings {
  AppStrings._();

  // App
  static const appName = 'SafeHouse';
  static const appTagline = 'Aluguel seguro e conectado';

  // Auth
  static const loginContinueWithGoogle = 'Continuar com Google';
  static const loginLoading = 'Entrando...';
  static const loginError = 'Falha ao fazer login. Tente novamente.';

  // App Bar
  static const greeting = 'Olá, ';
  static const welcomeBack = 'Bem-vindo de volta';
  static const defaultUserName = 'Usuário';
  static const defaultAvatarLetter = 'U';

  // Home
  static const homeFeedTitle = 'Encontre o Lugar Perfeito';
  static const homeErrorMessage = 'Erro ao carregar imóveis';
  static const homeRetry = 'Tentar novamente';
  static const homeEmpty = 'Nenhum imóvel encontrado';

  // Filtros
  static const filterAll = 'Todos';
  static const filterApartment = 'Apartamento';
  static const filterHouse = 'Casa';
  static const filterStudio = 'Estúdio';
  static const filterCommercial = 'Comercial';

  // Property Card
  static String brokerageLabel(int percent) =>
      '$percent% de corretagem em todos os negócios';
  static String priceLabel(String price) => 'R\$ $price/mês';
  static const bookNow = 'Alugar';

  // Navegação
  static const navHome = 'Início';
  static const navSearch = 'Busca';
  static const navFavorites = 'Favoritos';
  static const navProfile = 'Perfil';

  // Detalhe do Imóvel
  static const rent = 'Aluguel';
  static String brokerageBadge(int percent) => '$percent% corretagem';
  static String bedroomsLabel(int count) =>
      '$count ${count == 1 ? 'quarto' : 'quartos'}';
  static String bathroomsLabel(int count) =>
      '$count ${count == 1 ? 'banheiro' : 'banheiros'}';
  static String areaLabel(int sqm) => '$sqm m²';
  static const description = 'Descrição';
  static const amenities = 'Comodidades';
  static const legalProtectionTitle = 'Proteção Jurídica SafeHouse';
  static const legalProtectionDescription =
      'Este imóvel conta com suporte jurídico incluso';

  // Fluxo de Locação
  static const rentalTerms = 'Termos da Locação';
  static const contractDuration = 'Duração do Contrato';
  static const financialSummary = 'Resumo Financeiro';
  static const monthlyRent = 'Aluguel mensal';
  static const securityDeposit = 'Caução (3x aluguel)';
  static const totalFirstPayment = 'Total 1º pagamento';
  static const brokerage = 'Corretagem';
  static const legalProtectionIncluded =
      'Proteção jurídica SafeHouse inclusa neste contrato';
  static const termsAndConditions = 'Termos e Condições';
  static const termsText =
      'Ao prosseguir com a reserva, você concorda com os termos de locação '
      'do SafeHouse. O contrato será regido pela Lei do Inquilinato (Lei 8.245/91). '
      'A caução equivale a 3 meses de aluguel e será devolvida ao final do contrato, '
      'descontadas eventuais pendências. O suporte jurídico SafeHouse está incluso '
      'durante toda a vigência do contrato.';
  static const agreeToTerms = 'Li e concordo com os termos e condições';
  static const continueToReservation = 'Continuar para Reserva';

  // Confirmação de Reserva
  static const confirmReservation = 'Confirmar Reserva';
  static const almostThere = 'Quase lá!';
  static const reviewBeforeConfirm = 'Revise os dados antes de confirmar';
  static const propertyLabel = 'Imóvel';
  static const nameLabel = 'Nome';
  static const addressLabel = 'Endereço';
  static const confirmAndReserve = 'Confirmar e Reservar';
  static const reservationSuccess = 'Reserva Confirmada!';
  static String reservationSuccessMessage(String title) =>
      'Sua reserva para "$title" foi realizada com sucesso. '
      'Em breve entraremos em contato para os próximos passos.';
  static const backToHome = 'Voltar ao Início';

  // Filtros Avançados
  static const advancedFilters = 'Filtros Avançados';
  static const priceRange = 'Faixa de Preço';
  static const minPrice = 'Mínimo';
  static const maxPrice = 'Máximo';
  static const minBedrooms = 'Quartos (mínimo)';
  static const applyFilters = 'Aplicar Filtros';
  static const clearFilters = 'Limpar';
  static const searchByAddress = 'Buscar por endereço';

  // Dashboard Proprietário
  static const ownerDashboard = 'Meus Imóveis';
  static const activeContracts = 'Contratos Ativos';
  static const totalRevenue = 'Receita Total';
  static const occupancyRate = 'Taxa de Ocupação';
  static const noProperties = 'Nenhum imóvel cadastrado';

  // Perfil
  static const profile = 'Perfil';
  static const myContracts = 'Meus Contratos';
  static const settings = 'Configurações';
  static const logout = 'Sair';
  static const logoutConfirm = 'Deseja realmente sair?';
  static const cancel = 'Cancelar';
  static const confirm = 'Confirmar';
  static const tenant = 'Locatário';
  static const owner = 'Proprietário';

  // Status do Contrato
  static const statusAnuncio = 'Anúncio';
  static const statusReserva = 'Reserva';
  static const statusContratoAssinado = 'Contrato Assinado';
  static const statusEntregaChaves = 'Entrega de Chaves';
  static const statusLocacaoAtiva = 'Locação Ativa';
  static const statusInadimplente = 'Inadimplente';
  static const statusEncerramento = 'Encerrado';
}
