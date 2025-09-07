class Event {
  final String id;
  final String? name;
  final String? type;
  final String? url;
  final String? locale;
  final String? city;
  final String? country;
  final String? venue;
  final String? classification;
  final double? priceMin;
  final double? priceMax;
  final String? timezone;
  final String? startDate;
  final String? description;
  final String? info;
  final String? promoter;
  final List<String>? images;

  Event({
    required this.id,
    this.name,
    this.type,
    this.url,
    this.locale,
    this.city,
    this.country,
    this.venue,
    this.classification,
    this.priceMin,
    this.priceMax,
    this.timezone,
    this.startDate,
    this.description,
    this.info,
    this.promoter,
    this.images,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      name: map['name'],
      type: map['type'],
      url: map['url'],
      locale: map['locale'],
      city: map['_embedded']?['venues']?[0]?['city']?['name'],
      country: map['_embedded']?['venues']?[0]?['country']?['name'],
      venue: map['_embedded']?['venues']?[0]?['name'],
      classification: map['classifications']?[0]?['genre']?['name'],
      priceMin: map['priceRanges']?[0]?['min']?.toDouble(),
      priceMax: map['priceRanges']?[0]?['max']?.toDouble(),
      timezone: map['_embedded']?['venues']?[0]?['timezone'],
      startDate: map['dates']?['start']?['localDate'],
      description: map['description'],
      info: map['info'],
      promoter: map['promoter']?['name'],
      images: map['images'] != null
          ? List<String>.from(map['images'].map((img) => img['url'] as String))
          : null,
    );
  }
}
