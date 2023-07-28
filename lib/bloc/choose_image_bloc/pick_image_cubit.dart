import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/company_repo.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImageCubit extends Cubit<InitialImage> {
  final CompanyRepository companyRepository;
  PickImageCubit(this.companyRepository) : super(InitialImage());

  String imgUrl = "";
  String cvUrl = "";
  bool isCamera = false;

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  Future getStoragePermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.data}');

    if (await Permission.storage.request().isDenied) {
      print("333333333333333333333333333333333333333");
      print(" STATUS -------> ${await Permission.storage.status}");
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      emit(InitialImage());
    } else if (int.parse(androidInfo.version.release.toString()) < 12 &&
        await Permission.storage.request().isPermanentlyDenied) {
      print(" STATUS -------> ${await Permission.storage.status}");
      await openAppSettings();
    }
  }

  getImage() async {
    await getStoragePermission();
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
    getStoragePermission();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
        ]);

    if (result != null) {
      PlatformFile file = result.files.first;
      var img = File(file.path!);
      var base64 = base64Encode(img.readAsBytesSync());
      var type = getFileExtension(file.path!);
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
      emit(ImageErrorState("Please choose file"));
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
