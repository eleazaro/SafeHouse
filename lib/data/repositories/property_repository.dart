import '../../domain/models/property.dart';

/// Repositório de imóveis. Na v1, usa dados mockados.
/// Futuramente será substituído por chamadas ao backend.
abstract class PropertyRepository {
  Future<List<Property>> getProperties({int page = 0, int pageSize = 10});
  Future<Property?> getPropertyById(String id);
  Future<List<Property>> getFilteredProperties(PropertyFilter filter);
}

class PropertyFilter {
  final String? address;
  final double? latitude;
  final double? longitude;
  final double? radiusKm;
  final PropertyType? type;
  final double? minRent;
  final double? maxRent;
  final int? minBedrooms;

  const PropertyFilter({
    this.address,
    this.latitude,
    this.longitude,
    this.radiusKm,
    this.type,
    this.minRent,
    this.maxRent,
    this.minBedrooms,
  });
}

class MockPropertyRepository implements PropertyRepository {
  static final List<Property> _properties = [
    const Property(
      id: '1',
      title: 'Lumina Apartment',
      address: 'Rua das Flores, 120',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5505,
      longitude: -46.6333,
      rentPrice: 3200,
      type: PropertyType.apartment,
      brokeragePercent: 9,
      imageUrls: ['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800'],
      bedrooms: 2,
      bathrooms: 1,
      areaSqm: 68,
      description: 'Apartamento moderno com acabamento premium, próximo ao metrô.',
      amenities: ['Piscina', 'Academia', 'Churrasqueira', 'Vaga de garagem'],
    ),
    const Property(
      id: '2',
      title: 'Vibe Apartment',
      address: 'Av. Paulista, 1500',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5613,
      longitude: -46.6560,
      rentPrice: 4800,
      type: PropertyType.apartment,
      brokeragePercent: 12,
      imageUrls: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800'],
      bedrooms: 3,
      bathrooms: 2,
      areaSqm: 95,
      description: 'Cobertura duplex com vista panorâmica da Av. Paulista.',
      amenities: ['Rooftop', 'Coworking', 'Pet friendly', '2 vagas'],
    ),
    const Property(
      id: '3',
      title: 'Solar Residência',
      address: 'Rua Oscar Freire, 300',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5630,
      longitude: -46.6720,
      rentPrice: 6500,
      type: PropertyType.house,
      brokeragePercent: 8,
      imageUrls: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800'],
      bedrooms: 4,
      bathrooms: 3,
      areaSqm: 180,
      description: 'Casa em condomínio fechado com amplo jardim e área gourmet.',
      amenities: ['Jardim', 'Área gourmet', 'Segurança 24h', '3 vagas'],
    ),
    const Property(
      id: '4',
      title: 'Urban Studio',
      address: 'Rua Augusta, 800',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5540,
      longitude: -46.6570,
      rentPrice: 1800,
      type: PropertyType.studio,
      brokeragePercent: 10,
      imageUrls: ['https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800'],
      bedrooms: 1,
      bathrooms: 1,
      areaSqm: 35,
      description: 'Studio compacto e funcional no coração da Augusta.',
      amenities: ['Lavanderia', 'Bicicletário', 'Coworking'],
    ),
    const Property(
      id: '5',
      title: 'Horizonte Tower',
      address: 'Av. Brigadeiro Faria Lima, 2000',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5790,
      longitude: -46.6850,
      rentPrice: 5200,
      type: PropertyType.apartment,
      brokeragePercent: 9,
      imageUrls: ['https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800'],
      bedrooms: 3,
      bathrooms: 2,
      areaSqm: 110,
      description: 'Apartamento de alto padrão com varanda gourmet e vista livre.',
      amenities: ['Piscina', 'Sauna', 'Salão de festas', 'Playground'],
    ),
    const Property(
      id: '6',
      title: 'Espaço Comercial Centro',
      address: 'Rua XV de Novembro, 100',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5475,
      longitude: -46.6340,
      rentPrice: 7800,
      type: PropertyType.commercial,
      brokeragePercent: 7,
      imageUrls: ['https://images.unsplash.com/photo-1497366216548-37526070297c?w=800'],
      bedrooms: 0,
      bathrooms: 2,
      areaSqm: 200,
      description: 'Sala comercial ampla no centro histórico, ideal para escritório.',
      amenities: ['Recepção', 'Estacionamento', 'Segurança 24h'],
    ),
    const Property(
      id: '7',
      title: 'Vila Garden',
      address: 'Rua Harmonia, 45',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5560,
      longitude: -46.6910,
      rentPrice: 4200,
      type: PropertyType.house,
      brokeragePercent: 10,
      imageUrls: ['https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800'],
      bedrooms: 3,
      bathrooms: 2,
      areaSqm: 140,
      description: 'Casa charmosa na Vila Madalena com quintal arborizado.',
      amenities: ['Quintal', 'Churrasqueira', 'Edícula', '2 vagas'],
    ),
    const Property(
      id: '8',
      title: 'Loft Industrial',
      address: 'Rua Aspicuelta, 200',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5530,
      longitude: -46.6920,
      rentPrice: 2800,
      type: PropertyType.studio,
      brokeragePercent: 11,
      imageUrls: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800'],
      bedrooms: 1,
      bathrooms: 1,
      areaSqm: 55,
      description: 'Loft com pé direito duplo e estilo industrial contemporâneo.',
      amenities: ['Rooftop', 'Lavanderia', 'Pet friendly'],
    ),
    const Property(
      id: '9',
      title: 'Parque Residence',
      address: 'Av. Ibirapuera, 500',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5870,
      longitude: -46.6580,
      rentPrice: 5800,
      type: PropertyType.apartment,
      brokeragePercent: 8,
      imageUrls: ['https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800'],
      bedrooms: 4,
      bathrooms: 3,
      areaSqm: 150,
      description: 'Apartamento de luxo em frente ao Parque Ibirapuera.',
      amenities: ['Piscina', 'Spa', 'Cinema', 'Concierge'],
    ),
    const Property(
      id: '10',
      title: 'Compact Living',
      address: 'Rua Consolação, 1200',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5520,
      longitude: -46.6600,
      rentPrice: 1500,
      type: PropertyType.studio,
      brokeragePercent: 12,
      imageUrls: ['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'],
      bedrooms: 1,
      bathrooms: 1,
      areaSqm: 28,
      description: 'Kitnet mobiliada próxima à Mackenzie e à Paulista.',
      amenities: ['Mobiliado', 'Internet inclusa', 'Lavanderia'],
    ),
    const Property(
      id: '11',
      title: 'Sunset Penthouse',
      address: 'Rua Haddock Lobo, 800',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.5580,
      longitude: -46.6680,
      rentPrice: 8500,
      type: PropertyType.apartment,
      brokeragePercent: 7,
      imageUrls: ['https://images.unsplash.com/photo-1600607687644-c7171b42498f?w=800'],
      bedrooms: 4,
      bathrooms: 4,
      areaSqm: 220,
      description: 'Penthouse exclusiva com terraço privativo e vista do pôr do sol.',
      amenities: ['Terraço', 'Jacuzzi', 'Adega', 'Home theater', '3 vagas'],
    ),
    const Property(
      id: '12',
      title: 'Tech Hub Office',
      address: 'Av. Eng. Luís Carlos Berrini, 1000',
      city: 'São Paulo',
      state: 'SP',
      latitude: -23.6000,
      longitude: -46.6930,
      rentPrice: 12000,
      type: PropertyType.commercial,
      brokeragePercent: 6,
      imageUrls: ['https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=800'],
      bedrooms: 0,
      bathrooms: 4,
      areaSqm: 350,
      description: 'Escritório corporativo na região da Berrini com infraestrutura completa.',
      amenities: ['Heliponto', 'Auditório', 'Copa', 'Segurança 24h', '10 vagas'],
    ),
  ];

  @override
  Future<List<Property>> getProperties({int page = 0, int pageSize = 10}) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 800));

    final start = page * pageSize;
    if (start >= _properties.length) return [];
    final end = (start + pageSize).clamp(0, _properties.length);
    return _properties.sublist(start, end);
  }

  @override
  Future<Property?> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Property>> getFilteredProperties(PropertyFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return _properties.where((p) {
      if (filter.type != null && p.type != filter.type) return false;
      if (filter.minRent != null && p.rentPrice < filter.minRent!) return false;
      if (filter.maxRent != null && p.rentPrice > filter.maxRent!) return false;
      if (filter.minBedrooms != null && p.bedrooms < filter.minBedrooms!) return false;
      if (filter.address != null && filter.address!.isNotEmpty) {
        final query = filter.address!.toLowerCase();
        if (!p.address.toLowerCase().contains(query) &&
            !p.city.toLowerCase().contains(query) &&
            !p.title.toLowerCase().contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}
