import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:insta_job/model/location_model.dart';

class LocationInitial {}

class AddressLoading extends LocationInitial {}

class OnMapCreate extends LocationInitial {
  final Set<Marker> setOfMarker;

  OnMapCreate({required this.setOfMarker});
}

class CurrentLocation extends LocationInitial {
  final String location;

  CurrentLocation(this.location);
}

class AddressLoaded extends LocationInitial {
  final List<Prediction> list;

  AddressLoaded(this.list);
}

class PlaceByIdLoaded extends LocationInitial {
  final List<GetPlaceById> list;

  PlaceByIdLoaded(this.list);
}
