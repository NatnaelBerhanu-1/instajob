import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/location_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationCubit extends Cubit<LocationInitial> {
  final JobPositionRepository jobPosRepository;

  LocationCubit(this.jobPosRepository) : super(LocationInitial());

  /// Search Location ///
  Future<List<Prediction>> getLocation(input) async {
    ApiResponse response = await jobPosRepository.getLocation(input);
    if (response.response.statusCode == 200) {
      List<Prediction> list = List<Prediction>.from(response
          .response.data['predictions']
          .map((e) => Prediction.fromJson(e)));
      emit(AddressLoaded(list));
      return list;
    } else {
      showToast("Something went wrong");
      return [];
    }
  }

  LocationModel location = LocationModel();
  String address = "";

  getAddress(val) {
    address = val;
    emit(LocationInitial());
  }

  clearAddress() {
    address = "";
    emit(LocationInitial());
  }

  getPlaceById(input) async {
    ApiResponse response = await jobPosRepository.getPlaceById(input);
    if (response.response.statusCode == 200) {
      location = LocationModel.fromJson(
          response.response.data["result"]['geometry']['location']);
      // emit(PlaceByIdLoaded(list));
      // return list;
    } else {
      showToast("Something went wrong");
      return [];
    }
  }

  /// ON MAP CREATED ///
  double latitude = 0;
  double longitude = 0;

  GoogleMapController? googleMapController;
  Set<Marker> setOfMarker = {};

  onMapCreated(BuildContext context) {
    setOfMarker.clear();
    var locationData = context.read<JobPositionBloc>();
    for (int i = 0; i < locationData.jobDistanceList.length; i++) {
      print("|||||||||||||| FOR LOOP |||||||||||||||");
      var jobData = locationData.jobDistanceList[i];
      final marker = Marker(
          markerId: MarkerId(jobData.id.toString()),
          position: LatLng(
            double.parse(jobData.cLat.toString()),
            double.parse(jobData.cLog.toString()),
          ),
          infoWindow: InfoWindow(title: jobData.designation));
      setOfMarker.add(marker);
      emit(OnMapCreate(setOfMarker: setOfMarker));
    }
  }

  /// ========== CURRENT LOCATION ==========///
  List<Placemark> placeMarks = [];

  getCurrentLocation(BuildContext context) async {
    Position position = await determinePosition(context);
    latitude = position.latitude;
    longitude = position.longitude;
    placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // log(" ${placeMarks}");
    // log(" ${placeMarks[0].name}");
    emit(CurrentLocation(placeMarks.first.name.toString(), lat: latitude, long: longitude));

    print("############## $latitude");
    print("############## $longitude");
  }

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     showToast('Location services are disabled.');
    //   });
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      var sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getBool("location_denied")  != true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        buildDialog(context, CustomDialog(
          headerImagePath: MyImages.cancel,
          confirmBtnLabel: "Continue",
          popAfterOnTap: true,
          title: "Location Permission",
          desc1: "Location permission is needed to filter jobs near you. please enable?",
          cancelOnTap: () async{
            await sharedPreferences.setBool("location_denied", true);
          },
                          okOnTap: () async {
                            permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showToast('Location permissions are denied.');
        });
        return Future.error('Location permissions are denied');
      }
                          },
                        ));
      });
      }
      
      
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // openAppSettings();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   showToast(
      //       'Location permissions are permanently denied, we cannot request permissions.');
      // });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
