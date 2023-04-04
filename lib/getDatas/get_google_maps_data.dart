import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'datas/pharmacy_list.dart';

class GetGoogleMapsData extends StatefulWidget {
  const GetGoogleMapsData({super.key});

  @override
  State<GetGoogleMapsData> createState() => _GetGoogleMapsDataState();
}

//  I created a GoogleMapController.
late GoogleMapController myController;

//  to get marker location from firestore i created a gerMarkerData() class
//  and map it to json from my pharmacy_list.dart file.
Stream<Set<Pharmacy>> getMarkerData() => FirebaseFirestore.instance
    .collection('pharmacyList')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Pharmacy.fromJson(doc.data())).toSet());

//  I created a Marker class named buildmarker in order to add markers for GoogleMaps.
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
    //  I created a Streambuilder and to match with my getMarkerData() i assigned it to <Set<Pharmacy>>.
    return StreamBuilder<Set<Pharmacy>>(
      //  Our strem is getmarkardata class.
      stream: getMarkerData(),
      builder: (context, snapshot) {
        //  if we failed to get data, we return a text with error code.
        if (snapshot.hasError) {
          return Text('wrong! $snapshot');
          //  if we get data successfully magic happens.
        } else if (snapshot.hasData) {
          //  data assigned to pharmacy variable.
          final pharmacy = snapshot.data!;
          //  we change it to set.
          pharmacy.toSet();
          // here is just normal google maps widget.
          return GoogleMap(
            mapType: MapType.normal,
            //  initial postion is in: Istanbul
            initialCameraPosition: const CameraPosition(
              target: LatLng(41.015137, 28.979530),
              zoom: 8.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              myController = controller;
            },
            //  and finally we can build markers by using our data and buildmarker method.
            markers: pharmacy.map(buildMarker).toSet(),
          );
          //  if nothing happens and we just need to wait than we show a CircularProgressIndicator.
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
