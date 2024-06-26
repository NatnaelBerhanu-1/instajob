class UploadRecruiterKycPayload {
  String fullName;
  String phoneNumber;
  String email;
  String businessName;
  String businessType;
  String businessAddress;
  String documentType; // ["Driving License", "Passport", "ID Card"];
  String frontIdImageUrl;
  String backIdImageUrl;
  UploadRecruiterKycPayload({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.businessName,
    required this.businessType,
    required this.businessAddress,
    required this.documentType,
    required this.frontIdImageUrl,
    required this.backIdImageUrl,
  });



  UploadRecruiterKycPayload copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? businessName,
    String? businessType,
    String? businessAddress,
    String? documentType,
    String? frontIdImageUrl,
    String? backIdImageUrl,
  }) {
    return UploadRecruiterKycPayload(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      businessAddress: businessAddress ?? this.businessAddress,
      documentType: documentType ?? this.documentType,
      frontIdImageUrl: frontIdImageUrl ?? this.frontIdImageUrl,
      backIdImageUrl: backIdImageUrl ?? this.backIdImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'businessName': businessName,
      'businessType': businessType,
      'businessAddress': businessAddress,
      'documentType': documentType,
      'frontIdImageUrl': frontIdImageUrl,
      'backIdImageUrl': backIdImageUrl,
    };
  }

  @override
  String toString() {
    return 'UploadRecruiterKycPayload(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, businessName: $businessName, businessType: $businessType, businessAddress: $businessAddress, documentType: $documentType, frontIdImageUrl: $frontIdImageUrl, backIdImageUrl: $backIdImageUrl)';
  }
}
