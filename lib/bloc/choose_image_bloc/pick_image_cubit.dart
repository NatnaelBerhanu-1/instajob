import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/company_repo.dart';

class PickImageCubit extends Cubit<InitialImage> {
  final CompanyRepository companyRepository;
  PickImageCubit(this.companyRepository) : super(InitialImage());

  String imgUrl = "";
  String cvUrl = "";
  bool isCamera = false;

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  getImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(
      source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (image != null) {
      File? img;
      img = File(image.path);
      var base64 = base64Encode(img.readAsBytesSync());
      var type = getFileExtension(image.path);
      emit(LoadingImageState());
      ApiResponse response =
          await companyRepository.base64ImgApi(base64, ".$type");
      print('TYPEE **************      $type');
      if (response.response.statusCode == 200) {
        imgUrl = response.response.data['data'];
        print('URL ---------      ---- $imgUrl');
        emit(PickImageState(imgUrl));
      } else {
        emit(ImageErrorState("Something went wrong"));
      }
    } else {
      emit(ImageErrorState("Please choose image"));
    }
  }

  getCvImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (image != null) {
      File? img;
      img = File(image.path);
      var base64 = base64Encode(img.readAsBytesSync());
      var type = getFileExtension(image.path);
      emit(LoadingImageState());
      ApiResponse response =
          await companyRepository.base64ImgApi(base64, ".$type");
      print('TYPEE **************      $type');
      if (response.response.statusCode == 200) {
        cvUrl = response.response.data['data'];
        print('CV URL ---------      ---- $cvUrl');
        emit(PickCVImageState(cvUrl));
      } else {
        emit(ImageErrorState("Something went wrong"));
      }
    } else {
      emit(ImageErrorState("Please choose image"));
    }
  }

  clearImgUrl() {
    imgUrl = "";
    emit(InitialImage());
  }

  clearCVUrl() {
    cvUrl = "";
    emit(ClearImageState());
  }
}
