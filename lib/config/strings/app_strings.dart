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
}
