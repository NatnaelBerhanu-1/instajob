import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_data.dart';

class FetchedKycRecruiterData extends FetchedKycData {
    final int id;
    final int userId;
    final String name;
    final String email;
    final String documentType;
    final String idFront;
    final String idBack;
    final String businessName;
    final String businessAs;
    final String businessAddress;
    final String phoneNumber;

    FetchedKycRecruiterData({
        required this.id,
        required this.userId,
        required this.name,
        required this.email,
        required this.documentType,
        required this.idFront,
        required this.idBack,
        required this.businessName,
        required this.businessAs,
        required this.businessAddress,
        required this.phoneNumber,
    });

    FetchedKycRecruiterData copyWith({
        int? id,
        int? userId,
        String? name,
        String? email,
        String? documentType,
        String? idFront,
        String? idBack,
        String? businessName,
        String? businessAs,
        String? businessAddress,
        String? phoneNumber,
    }) => 
        FetchedKycRecruiterData(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            email: email ?? this.email,
            documentType: documentType ?? this.documentType,
            idFront: idFront ?? this.idFront,
            idBack: idBack ?? this.idBack,
            businessName: businessName ?? this.businessName,
            businessAs: businessAs ?? this.businessAs,
            businessAddress: businessAddress ?? this.businessAddress,
            phoneNumber: phoneNumber ?? this.phoneNumber,
        );

    factory FetchedKycRecruiterData.fromMap(Map<String, dynamic> map) {
      return FetchedKycRecruiterData(
        id: map["id"],
        userId: map["user_id"],
        name: map["name"],
        email: map["email"],
        documentType: map["document_type"],
        idFront: map["id_front"],
        idBack: map["id_back"],
        businessName: map["business_name"],
        businessAs: map["business_as"],
        businessAddress: map["business_address"],
        phoneNumber: map["phone_number"],
    );
    }
}
