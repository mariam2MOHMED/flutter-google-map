import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final Completer<GoogleMapController>_controller=
  Completer<GoogleMapController>();
  String mapStyle="";
  Set<Marker>markers={

  };
  bool isPermission=false;
  LatLng? _currentLocation;
  Set<Polyline>polyines={};
  StreamSubscription<Position>?_streamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _checkPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:      GoogleMap(
myLocationEnabled: true,
myLocationButtonEnabled: true,
markers: markers,
          onMapCreated: (controller){


            setState(() async {
              _controller.complete(controller);
              markers.addAll({
                Marker(

                     
                    markerId: MarkerId("M2"), position:
                LatLng(30.5426845,30.8713126),
                    infoWindow:  InfoWindow( title: "m2",snippet: "sub title 2")
                ),
                Marker(
                  icon: await _customIcon(),
                    position: LatLng(30.3404264,31.1671849),
                    markerId: MarkerId("M1"),

                    infoWindow:
                    InfoWindow( title: "m1",snippet: "sub title 1"))
              });
              polyines.addAll({

      Polyline(polylineId: PolylineId("P1"),
      color: Colors.pink,
        width: 4,
        points: [
          LatLng(31.0413845,31.4034392,),
          LatLng(31.0515464,31.4286968),
        ]
      )          
              });
            });
            
          },

          initialCameraPosition:
          CameraPosition(target:
          LatLng(31.0413845,31.4034392,),zoom: 14)),
      
      floatingActionButton:
      FloatingActionButton(onPressed: (){
        _moveToCairo();
      },
      child: Icon(Icons.ac_unit),
      ),
    );
  }

  void _moveToCairo() async{
    final GoogleMapController controller=await _controller.future;
    controller.animateCamera(CameraUpdate.
    newCameraPosition(CameraPosition(target: LatLng(
        30.3838249,31.1939641
    ),
    zoom: 12
    ),

    ),
    );
  }
  _setMapStyle() async {
 mapStyle=await DefaultAssetBundle.of(context).loadString
      ("assets/map_style/map_style.json");

  }
Future<BitmapDescriptor>_customIcon()async{
    return await BitmapDescriptor.asset(ImageConfiguration(
      size: Size(48, 48)
    ), "assets/map_style/gps.png");
}
_checkPermission()async{
    final status=await Permission.location.request();
    if(status.isGranted){
    setState(() {
      isPermission=true;
    });
_getUserLocation();
    }
    else{
//show dialog
    }
    setState(() {

    });
}

  void _getUserLocation() async{
    if(isPermission){return;}
    else{
  final Position position=await    Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high
          ));
  setState(() {

    _currentLocation=LatLng(position.latitude, position.longitude);
  });

if(_currentLocation==null){return;}
  final GoogleMapController controller=await _controller.future;
  controller.animateCamera(CameraUpdate.
  newCameraPosition(CameraPosition(
      target: _currentLocation!,zoom: 14),

  ));
    }
    _startTracking();
  }
  void _startTracking() async {
    _streamSubscription =
        Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high))
            .listen((Position position) {
          setState(() {
            _currentLocation = LatLng
              (position.latitude, position.longitude);
          });

          _controller.future.then((controller) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _currentLocation ?? const LatLng(30.032147643718574, 31.463156048547326),
                  zoom: 14,
                ),
              ),
            );
          });
        });
  }
}

