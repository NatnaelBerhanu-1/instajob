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
  String bankCode;
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
    required this.bankCode,
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
    String? bankCode,
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
      bankCode: bankCode ?? this.bankCode,
      countryCode: countryCode ?? this.countryCode,
      bankAccountOwnerFullName: bankAccountOwnerFullName ?? this.bankAccountOwnerFullName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'document_type': documentType,
      'id_front': frontIdImageUrl,
      'id_back': backIdImageUrl,
      'account_number': bankAccountNumber,
      'account_type': bankAccountType,
      'bank_code': bankCode,
      'country_code': countryCode,
      'owner_full_name': bankAccountOwnerFullName,
    };
  }

  @override
  String toString() {
    return 'UploadCandidateKycPayload(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, documentType: $documentType, frontIdImageUrl: $frontIdImageUrl, backIdImageUrl: $backIdImageUrl, accountNumber: $bankAccountNumber, accountType: $bankAccountType, bankCode: $bankCode, countryCode: $countryCode, bankAccountOwnerFullName: $bankAccountOwnerFullName)';
  }
}
