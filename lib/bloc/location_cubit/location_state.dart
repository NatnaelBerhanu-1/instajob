import 'package:insta_job/model/location_model.dart';

class LocationInitial {}

class AddressLoading extends LocationInitial {}

class AddressLoaded extends LocationInitial {
  final List<GetLocation> list;

  AddressLoaded(this.list);
}
