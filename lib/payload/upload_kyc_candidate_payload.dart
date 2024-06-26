import 'package:insta_job/payload/upload_kyc_payload.dart';

class UploadCandidateKycPayload extends UploadKycPayload {
  String fullName;
  String phoneNumber;
  String email;
  String documentType; // ["Driving License", "Passport", "ID Card"];
  String frontIdImageUrl;
  String backIdImageUrl;
  String bankAccountNumber;
  String bankAccountType;
  String countryCode;
  String bankAccountOwnerFullName;
  UploadCandidateKycPayload({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.documentType,
    required this.frontIdImageUrl,
    required this.backIdImageUrl,
    required this.bankAccountNumber,
    required this.bankAccountType,
    required this.countryCode,
    required this.bankAccountOwnerFullName,
  });



  UploadCandidateKycPayload copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? documentType,
    String? frontIdImageUrl,
    String? backIdImageUrl,
    String? bankAccountNumber,
    String? bankAccountType,
    String? countryCode,
    String? bankAccountOwnerFullName,
  }) {
    return UploadCandidateKycPayload(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      documentType: documentType ?? this.documentType,
      frontIdImageUrl: frontIdImageUrl ?? this.frontIdImageUrl,
      backIdImageUrl: backIdImageUrl ?? this.backIdImageUrl,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountType: bankAccountType ?? this.bankAccountType,
      countryCode: countryCode ?? this.countryCode,
      bankAccountOwnerFullName: bankAccountOwnerFullName ?? this.bankAccountOwnerFullName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'documentType': documentType,
      'frontIdImageUrl': frontIdImageUrl,
      'backIdImageUrl': backIdImageUrl,
      'accountNumber': bankAccountNumber,
      'accountType': bankAccountType,
      'countryCode': countryCode,
      'bankAccountOwnerFullName': bankAccountOwnerFullName,
    };
  }

  @override
  String toString() {
    return 'UploadCandidateKycPayload(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, documentType: $documentType, frontIdImageUrl: $frontIdImageUrl, backIdImageUrl: $backIdImageUrl, accountNumber: $bankAccountNumber, accountType: $bankAccountType, countryCode: $countryCode, bankAccountOwnerFullName: $bankAccountOwnerFullName)';
  }
}
