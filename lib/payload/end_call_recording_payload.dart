
import 'package:equatable/equatable.dart';

class EndCallRecordingPayload extends Equatable {
  final String? recordingUid;
  final String? resourceId;
  final String? sId;
  final String? channelName;

  const EndCallRecordingPayload({
    this.recordingUid,
    this.resourceId,
    this.sId,
    this.channelName,
  });

  Map<String, dynamic> toMap() {
    return <String, String>{
      "uid": recordingUid != null ? recordingUid.toString() : "",
      "resource": resourceId != null ? resourceId.toString() : "",
      "sid": sId != null ? sId.toString() : "",
      "channel": channelName != null ? channelName.toString() : "",
    };
  }
  
  @override
  List<Object?> get props => [recordingUid, resourceId, sId, channelName];
}
