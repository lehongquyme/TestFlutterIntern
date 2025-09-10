class Address {
  final String title;
  final String fullAddress;
  final double lon;
  final double lat;

  Address({
    required this.title,
    required this.fullAddress,
    required this.lon,
    required this.lat,
  });

  //LocationIQ Api
  factory Address.fromLocationIqJson(Map<String, dynamic> json) {
    return Address(
      title: json["display_name"] ?? '',
      fullAddress: json["display_name"] ?? '',
      lon: double.tryParse(json['lon'] ?? '0') ?? 0,
      lat: double.tryParse(json['lat'] ?? '0') ?? 0,
    );
  }

  // OpenStreetMap
  factory Address.fromNominatimJson(Map<String, dynamic> json) {
    return Address(
      title: json["display_name"] ?? '',
      fullAddress: json["display_name"] ?? '',
      lon: double.tryParse(json['lon'] ?? '0') ?? 0,
      lat: double.tryParse(json['lat'] ?? '0') ?? 0,
    );
  }
  Map<String,dynamic> toJson() {
    return {
      'title': title,
      'fullAddress': fullAddress,
      'lon': lon,
      'lat': lat,
    };
  }
  @override
  String toString() {
    return '$title\n$fullAddress\n$lon\n$lat';
  }

}
