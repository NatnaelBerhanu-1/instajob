import 'package:google_maps_webservice/places.dart';
import 'package:insta_job/model/location_model.dart';

class LocationInitial {}

class AddressLoading extends LocationInitial {}

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
