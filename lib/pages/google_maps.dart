import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../component/pharmacy_list.dart';
import 'new_home_page.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

Stream<Set<Pharmacy>> getMarkerData() => FirebaseFirestore.instance
    .collection('pharmacyList')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Pharmacy.fromJson(doc.data())).toSet());

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController myController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.to(NewHomePage()),
        ),
      ),
      body: StreamBuilder<Set<Pharmacy>>(
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
                  target: LatLng(39.925533, 32.866287),
                  zoom: 13.0,
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
          }),
    );
  }
}

Marker buildMarker(Pharmacy pharmacy) => Marker(
      markerId: MarkerId(pharmacy.id.toString()),
      position: LatLng(pharmacy.latitude, pharmacy.longitude),
      infoWindow: InfoWindow(
        title: pharmacy.name,
        snippet: pharmacy.address,
      ),
    );
