import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'datas/pharmacy_list.dart';

class GetGoogleMapsData extends StatefulWidget {
  const GetGoogleMapsData({super.key});

  @override
  State<GetGoogleMapsData> createState() => _GetGoogleMapsDataState();
}

late GoogleMapController myController;
Stream<Set<Pharmacy>> getMarkerData() => FirebaseFirestore.instance
    .collection('pharmacyList')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Pharmacy.fromJson(doc.data())).toSet());

Marker buildMarker(Pharmacy pharmacy) => Marker(
      markerId: MarkerId(pharmacy.id),
      position: LatLng(pharmacy.latitude, pharmacy.longitude),
      infoWindow: InfoWindow(
        title: pharmacy.name,
        snippet: pharmacy.address,
      ),
    );

class _GetGoogleMapsDataState extends State<GetGoogleMapsData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set<Pharmacy>>(
      stream: getMarkerData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('wrong! $snapshot');
        } else if (snapshot.hasData) {
          final pharmacy = snapshot.data!;
          pharmacy.toSet();
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(41.015137, 28.979530),
              zoom: 8.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              myController = controller;
            },
            markers: pharmacy.map(buildMarker).toSet(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
