
import 'package:equatable/equatable.dart';

class EndCallTranscriptionPayload extends Equatable {
  final String? builderToken;

  const EndCallTranscriptionPayload({
    this.builderToken,
  });

  Map<String, dynamic> toMap() {
    return <String, String>{
      "builder_token": builderToken != null ? builderToken.toString() : "",
    };
  }
  
  @override
  List<Object?> get props => [builderToken];
}
