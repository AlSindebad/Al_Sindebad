class Place {
  final String id;
  final String name;
  final List<String> images;
  final int stars;
  final String description;
  final String locationUrl;
  final String category;

  Place({
    required this.id,
    required this.name,
    required this.images,
    required this.stars,
    required this.description,
    required this.locationUrl,
    required this.category,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      stars: json['stars'] ?? '0' ?? 0,
      description: json['description'] ?? '',
      locationUrl: json['locationUrl'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

