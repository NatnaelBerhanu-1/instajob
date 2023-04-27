class InitialImage {}

class PickImageState extends InitialImage {
  final String url;

  PickImageState(this.url);
}

class LoadingImageState extends InitialImage {}

class ImageErrorState extends InitialImage {
  final String imageError;

  ImageErrorState(this.imageError);
}
