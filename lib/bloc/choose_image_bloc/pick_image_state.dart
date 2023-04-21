class InitialImage {}

class PickImageState extends InitialImage {
  final String url;

  PickImageState(this.url);
}

class ImageErrorState extends InitialImage {
  final String imageError;

  ImageErrorState(this.imageError);
}
