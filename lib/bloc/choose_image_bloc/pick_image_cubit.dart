import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/company_repo.dart';

class PickImageCubit extends Cubit<InitialImage> {
  final CompanyRepository companyRepository;
  PickImageCubit(this.companyRepository) : super(InitialImage());
  File? img;
  String imgUrl = "";
  final picker = ImagePicker();
  bool isCamera = false;

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  getImage() async {
    var image = await picker.pickImage(
      source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (image != null) {
      img = File(image.path);
      var base64 = base64Encode(img!.readAsBytesSync());
      var type = getFileExtension(image.path);

      ApiResponse response =
          await companyRepository.base64ImgApi(base64, ".$type");
      print('TYPEE **************      $type');
      if (response.response.statusCode == 200) {
        imgUrl = response.response.data['data'];
      } else {
        showToast("111111111111");
      }
      print('URL ---------      ---- $imgUrl');
      emit(PickImageState(imgUrl));
    } else {
      emit(ImageErrorState("Please choose image"));
    }
  }
}
