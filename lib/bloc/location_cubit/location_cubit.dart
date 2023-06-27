import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/job_position_repo.dart';

import '../../model/location_model.dart';

class LocationCubit extends Cubit<LocationInitial> {
  final JobPositionRepository jobPosRepository;
  LocationCubit(this.jobPosRepository) : super(LocationInitial());

  getLocation(input) async {
    ApiResponse response = await jobPosRepository.getLocation(input);
    if (response.response.statusCode == 200) {
      var list = List<GetLocation>.from(response.response.data['predictions']
          .map((e) => GetLocation.fromJson(e)));
      emit(AddressLoaded(list));
      return list;
    } else {
      showToast("message");
    }
  }
}
