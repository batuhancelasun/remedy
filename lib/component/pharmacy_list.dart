import 'package:cloud_firestore/cloud_firestore.dart';

class Pharmacy {
  final String  id;
  final String address;
  final String name;
  final double longitude;
  final double latitude;

  Pharmacy({
    required this.id,
    required this.address,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

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
