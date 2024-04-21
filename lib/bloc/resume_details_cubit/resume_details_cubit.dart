import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_details_cubit/resume_details_state.dart';
import 'package:insta_job/model/resume_detail_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/resume_repo.dart';

class ResumeDetailsCubit extends Cubit<ResumeDetailsState> {
  final ResumeRepository repo;
  ResumeDetailsCubit(this.repo) : super(ResumeDetailsInitial());

  Future<void> execute({
    required String? resumeUrl,
  }) async {
    emit(ResumeDetailsLoading());
    // await Future.delayed(const Duration(seconds: 2));
    // emit(ResumeDetailsSuccess(resumeDetail: mockResumeDetail)); //TODO: replace mock with real data
    debugPrint('getting resume details');
    ApiResponse response = await repo.getParsedResumeDetails(resumeUrl: resumeUrl);

    if (response.appStatusCode == AppStatusCode.serverError) {
      emit(ResumeDetailsErrorState(message: "Server error. Something went wrong. Please try again."));
    }
    if (response.appStatusCode == AppStatusCode.success) {
      ResumeDetailModel resumeDetail = response.response as ResumeDetailModel;
      emit(ResumeDetailsSuccess(resumeDetail: resumeDetail));
    } else {
      emit(ResumeDetailsErrorState(message: "Data not found"));
    }
  }

  ResumeDetailModel mockResumeDetail = ResumeDetailModel(
      address: "1515 Pacific Ave\nLos Angeles, CA 90291\nUnited States",
      educationDetail: [
        EducationDetail(name: "Graduate School"),
        EducationDetail(name: "Atlanta Technical College"),
        EducationDetail(name: "Graduate School USA"),
        EducationDetail(name: "Southern New Hampshire University")
      ],
      email: "email@email.com",
      phone: "3868683442",
      //todo: add phone num
      experience: [
        Experience(location: "Miami Gardens", organization: "Employment History", title: "Associate"),
        Experience(location: "Miami Gardens", organization: "Amazon", title: "Warehouse Associate"),
        Experience(location: "Atlanta", organization: "Atlanta Technical College", title: "Associate"),
        Experience(location: "Atlanta", organization: "Atlanta Technical College", title: "Associate"),
      ],
      name: "Jason Miller",
      skills: [
        "Inventory",
        "Mathematics",
        "Spanish",
        "Operations",
        "Logistics",
        "Warehouse",
        "English",
        "Distribution",
        "Technical"
      ]);
}
