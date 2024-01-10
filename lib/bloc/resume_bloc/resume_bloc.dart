import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/model/cover_letter_model.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/resume_repo.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final ResumeRepository resumeRepository;

  getResumeData(String id, Emitter emit) async {
    ApiResponse response = await resumeRepository.getResume(id: id);
    if (response.response.statusCode == 500) {
      emit(const ErrorState("Something went wrong"));
    }
    if (response.response.success == 200) {
      CoverLetterModel coverLetterModel =
          CoverLetterModel.fromJson(response.response.data['data']);
      emit(ResumeLoaded(resumeModel: coverLetterModel));
    } else if (response.response.success == 400) {
      emit(const ErrorState("Data not found"));
    }
  }

  // List<Educations> addNewEducation = [];
  // List<WorkExperiences> addNewWorkExp = [];
  ResumeModel resumeModel = ResumeModel();

  ResumeBloc(this.resumeRepository) : super(ResumeInitial()) {
    on<LoadResumeEvent>((event, emit) async {
      var resumeData = await getResumeData(event.id, emit);
      emit(ResumeLoaded(resumeModel: resumeData));
    });

    on<AddResumeEvent>((event, emit) async {
      ApiResponse response = await resumeRepository.addResume(
        name: event.coverLetterModel.yourName,
        passion: event.coverLetterModel.yourPassion,
        pWork: event.coverLetterModel.previousWork,
        skills: event.coverLetterModel.yourTop5Skills,
        phoneNumber: event.coverLetterModel.phoneNumber.toString(),
      );
      await getResumeData(
          response.response.data['data']['id'].toString(), emit);
    });
    on<AddEducationEvent>((event, emit) async {
      emit(ResumeLoading());
      // if (event.isNew) {
      //   addNewEducation.add(event.educationModel);
      //   emit(ResumeAddSuccess());
      // } else {
      ApiResponse response =
          await resumeRepository.addEducation(education: event.educationModel);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // addNewEducation.add(event.educationModel);
        emit(EducationAddSuccess());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
      // }
    });

    on<TellMeAbtYourSelfEvent>((event, emit) async {
      emit(ResumeLoading());
      ApiResponse response =
          await resumeRepository.addTellAbtSelf(tellUs: event.data);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<AddWorkExpEvent>((event, emit) async {
      // if (event.isNew) {
      //   addNewWorkExp.add(event.workExpModel);
      //   emit(ResumeAddSuccess());
      // } else {
      ApiResponse response = await resumeRepository.addWorkExperience(
          workExpModel: event.workExpModel);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // showToast("Success");
        // addNewWorkExp.add(event.workExpModel);
        emit(ExpAddSuccess());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
      // }
    });

    on<AddSkillsEvent>((event, emit) async {
      ApiResponse response =
          await resumeRepository.addSkills(skills: event.skills);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<AddAchievementEvent>((event, emit) async {
      ApiResponse response =
          await resumeRepository.addAchievement(ach: event.ach);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<UserResumeLoadedEvent>((event, emit) async {
      ApiResponse response =
          await resumeRepository.showCreatedResumes(userId: event.userId);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        resumeModel = ResumeModel.fromJson(response.response.data["data"]);
        emit(UserResumeLoaded(resumeModel: resumeModel));
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<DeleteEducation>((event, emit) async {
      ApiResponse response =
          await resumeRepository.deleteEducation(id: event.id);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // addNewEducation.removeAt(event.index!);
        emit(ResumeDeleted());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<DeleteWorkExp>((event, emit) async {
      ApiResponse response = await resumeRepository.deleteWorkExp(id: event.id);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // addNewWorkExp.removeAt(event.index!);
        emit(ResumeDeleted());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });
  }
/*
  String name = "";
  String phone = "";
  String passion = "";
  String pWork = "";
  changeName(val) {
    name = val;
    emit(NameState());
  }

  changePhone(val) {
    phone = val;

  }

  changePassion(val) {
    passion = val;
  }

  changePWork(val) {
    pWork = val;
  }*/
}
/*
  bool readOnly = true;
  bool isConfirm = false;
on<CheckReadOnlyEvent>((event, emit) {
      readOnly = event.readOnly;
      emit(CheckReadOnly(readOnly));
    });
    on<CheckIsConfirmEvent>((event, emit) {
      isConfirm = event.isConfirm;
      emit(CheckConfirm(isConfirm));
    });*/
