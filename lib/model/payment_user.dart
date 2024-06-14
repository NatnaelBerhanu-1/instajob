import 'package:equatable/equatable.dart';

class PaymentUser extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String? type;
  final String? fcmToken;
  final String? firebaseId;
  final String? phoneNumber;
  final String? uploadPhoto;
  final String? date;
  final String? cv;

  const PaymentUser({
    required this.id,
    required this.name,
    required this.email,
    this.type,
    this.fcmToken,
    this.firebaseId,
    this.phoneNumber,
    this.uploadPhoto,
    this.date,
    this.cv,
  });

  PaymentUser copyWith({
    int? id,
    String? name,
    String? email,
    String? type,
    String? fcmToken,
    String? firebaseId,
    String? phoneNumber,
    String? uploadPhoto,
    String? date,
    String? cv,
  }) =>
      PaymentUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        type: type ?? this.type,
        fcmToken: fcmToken ?? this.fcmToken,
        firebaseId: firebaseId ?? this.firebaseId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        uploadPhoto: uploadPhoto ?? this.uploadPhoto,
        date: date ?? this.date,
        cv: cv ?? this.cv,
      );

  factory PaymentUser.fromJson(Map<String, dynamic> json) => PaymentUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        type: json["type"],
        fcmToken: json["fcm_token"],
        firebaseId: json["firebase_id"],
        phoneNumber: json["phone_number"],
        uploadPhoto: json["upload_photo"],
        date: json["date"],
        cv: json["cv"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "type": type,
        "fcm_token": fcmToken,
        "firebase_id": firebaseId,
        "phone_number": phoneNumber,
        "upload_photo": uploadPhoto,
        "date": date,
        "cv": cv,
      };
      
        @override
        // TODO: implement props
        List<Object?> get props => [
          id,
          name,
          email,
          type,
          fcmToken,
          firebaseId,
          phoneNumber,
          uploadPhoto,
          date,
          cv,
        ];
}

PaymentUser mockPaymentUser = const PaymentUser(id: 10101010, name: 'Nicholas M.', email: "nic@gmail.com");

List<PaymentUser> mockPaymentUsers = [
  const PaymentUser(id: 10101010, name: 'Nicholas M.', email: 'nic@gmail.com'),
  const PaymentUser(id: 10101011, name: 'Alex A.', email: 'alex@gmail.com'),
  const PaymentUser(id: 10101012, name: 'Nicholas M.', email: 'nic2@gmail.com'),
  const PaymentUser(id: 10101013, name: 'Sarah D.', email: 'sarah@gmail.com'),
  const PaymentUser(id: 10101014, name: 'Omar M.', email: 'omar@gmail.com'),
  const PaymentUser(id: 10101015, name: 'Mariam', email: 'mariam@gmail.com'),
  const PaymentUser(id: 10101016, name: 'Omar', email: 'omar2@gmail.com'),
  const PaymentUser(id: 10101017, name: 'Henry', email: 'henry2@gmail.com'),
  const PaymentUser(id: 10101018, name: 'Adam', email: 'adam@gmail.com'),
  const PaymentUser(id: 10101019, name: 'Russell', email: 'russell@gmail.com'),
  const PaymentUser(id: 10101020, name: 'Peter', email: 'peter@gmail.com'),
];