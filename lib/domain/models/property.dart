enum PropertyType {
  apartment,
  house,
  studio,
  commercial,
}

class Property {
  final String id;
  final String title;
  final String address;
  final String city;
  final String state;
  final double latitude;
  final double longitude;
  final double rentPrice;
  final PropertyType type;
  final double brokeragePercent;
  final List<String> imageUrls;
  final int bedrooms;
  final int bathrooms;
  final double areaSqm;
  final String description;
  final bool hasLegalSupport;
  final List<String> amenities;

  const Property({
    required this.id,
    required this.title,
    required this.address,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.rentPrice,
    required this.type,
    required this.brokeragePercent,
    required this.imageUrls,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqm,
    required this.description,
    this.hasLegalSupport = true,
    this.amenities = const [],
  });
}
