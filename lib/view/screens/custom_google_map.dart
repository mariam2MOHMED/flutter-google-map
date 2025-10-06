import 'package:flutter/material.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// class CustomGoogleMap extends StatefulWidget {
//   const CustomGoogleMap({super.key});
//
//   @override
//   State<CustomGoogleMap> createState() => _CustomGoogleMapState();
// }
//
// class _CustomGoogleMapState extends State<CustomGoogleMap> {
//   late CameraPosition cameraPosition;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     cameraPosition=CameraPosition(
//
//         target: LatLng(31, 41),
//       zoom: 14
//
//     );
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: GoogleMap(
//           cameraTargetBounds: CameraTargetBounds(LatLngBounds(
//                                         southwest: LatLng(31.08, 29.67),
//               northeast: LatLng(31.3, 30.1),)),
//           initialCameraPosition: cameraPosition),
//     );
//   }
// }
class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker>markers={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialCameraPosition=CameraPosition(target:
    LatLng(31.09,
        41.99),
        zoom: 14);
    initMarker();
  }
void initMarker(){
    var myMarker=Marker(markerId: MarkerId("4"),
    position: LatLng(30.3419503,31.1781714)
    );
    markers.add(myMarker);
    setState(() {
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:     Stack(
        children: [
          GoogleMap(
           mapType: MapType.normal,
            markers: markers,
              onMapCreated: (controller){
                googleMapController=controller;
          initMarkers();
              },
              // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              //   southwest: LatLng(31.08, 29.67),
              //   northeast: LatLng(31.3, 30.1),)),
              initialCameraPosition: initialCameraPosition),
          ElevatedButton(onPressed: (){
            CameraPosition newLocation=CameraPosition(target:
            LatLng(36.8979091,30.8005053),zoom: 7);
            googleMapController.animateCamera(
             CameraUpdate.newCameraPosition(newLocation));

            setState(() {

            });
          }, child: Text("Change Location"))
        ],
      )

    );


  }
void initMarkers()async{
  var myMarkers= places.map((place)=>Marker(
    infoWindow: InfoWindow(   title: place.name),
       position: place.latLng,
       markerId: MarkerId(place.id))).toSet();
  markers.addAll(myMarkers);
  setState(() {

  });
}
  // void initMapStyle() async{
  //   var style=await DefaultAssetBundle.
  //   of(context).loadString("assets/map_style/map_style.json");
  // googleMapController.setMapStyle(style);
  // }
}



