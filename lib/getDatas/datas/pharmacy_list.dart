class Pharmacy {
  Pharmacy({
    required this.id,
    required this.address,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  final String address;
  final String id;
  final double latitude;
  final double longitude;
  final String name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'name': name,
        'longitude': longitude,
        'latitude': latitude,
      };

  static Pharmacy fromJson(Map<String, dynamic> json) => Pharmacy(
        id: json['id'],
        address: json['address'],
        name: json['name'],
        longitude: json['longitude'],
        latitude: json['latitude'],
      );
}
