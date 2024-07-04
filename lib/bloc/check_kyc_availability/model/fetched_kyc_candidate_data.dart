import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_data.dart';

class FetchedKycCandidateData extends FetchedKycData {
    final int id;
    final int userId;
    final String name;
    final String email;
    final String documentType;
    final String idFront;
    final String idBack;
    final String accountNumber;
    final String accountType;
    final String bankCode;
    final String countryCode;
    final String ownerFullName;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String phoneNumber;

    FetchedKycCandidateData({
        required this.id,
        required this.userId,
        required this.name,
        required this.email,
        required this.documentType,
        required this.idFront,
        required this.idBack,
        required this.accountNumber,
        required this.accountType,
        required this.bankCode,
        required this.countryCode,
        required this.ownerFullName,
        required this.createdAt,
        required this.updatedAt,
        required this.phoneNumber,
    });

    FetchedKycCandidateData copyWith({
        int? id,
        int? userId,
        String? name,
        String? email,
        String? documentType,
        String? idFront,
        String? idBack,
        String? accountNumber,
        String? accountType,
        String? bankCode,
        String? countryCode,
        String? ownerFullName,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? phoneNumber,
    }) => 
        FetchedKycCandidateData(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            email: email ?? this.email,
            documentType: documentType ?? this.documentType,
            idFront: idFront ?? this.idFront,
            idBack: idBack ?? this.idBack,
            accountNumber: accountNumber ?? this.accountNumber,
            accountType: accountType ?? this.accountType,
            bankCode: bankCode ?? this.bankCode,
            countryCode: countryCode ?? this.countryCode,
            ownerFullName: ownerFullName ?? this.ownerFullName,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            phoneNumber: phoneNumber ?? this.phoneNumber,
        );

    factory FetchedKycCandidateData.fromMap(Map<String, dynamic> map) {
      return FetchedKycCandidateData(
        id: map["id"],
        userId: map["user_id"],
        name: map["name"],
        email: map["email"],
        documentType: map["document_type"],
        idFront: map["id_front"],
        idBack: map["id_back"],
        accountNumber: map["account_number"],
        accountType: map["account_type"],
        bankCode: map["bank_code"],
        countryCode: map["country_code"],
        ownerFullName: map["owner_full_name"],
        createdAt: DateTime.parse(map["created_at"]),
        updatedAt: DateTime.parse(map["updated_at"]),
        phoneNumber: map["phone_number"],
    );
    }
}
