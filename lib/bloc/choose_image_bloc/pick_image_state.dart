class InitialImage {}

class PickImageState extends InitialImage {
  final String url;

  PickImageState(this.url);
}

class PickCVImageState extends InitialImage {
  final String cvUrl;

  PickCVImageState(this.cvUrl);
}

class LoadingImageState extends InitialImage {}

class ClearImageState extends InitialImage {}

class ImageErrorState extends InitialImage {
  final String imageError;

  ImageErrorState(this.imageError);
}
