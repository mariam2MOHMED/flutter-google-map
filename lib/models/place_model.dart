import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{
  final String id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id,
    required this.name,
    required this.latLng});

}
List<PlaceModel>places=[
  PlaceModel(id: "1", name: "إكياد دجوي", latLng: LatLng(30.3660431,31.1095293)),
  PlaceModel(id: "2", name: "عرب الرمل", latLng: LatLng(30.5063146,31.1612514)),
  PlaceModel(id: "3", name: "جزيرة ابو رفيع", latLng: LatLng(30.3660431,31.1095293,))


];