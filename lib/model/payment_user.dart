import 'package:equatable/equatable.dart';

class PaymentUser extends Equatable {
  final int? id;
  final String? name;

  const PaymentUser({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

}

PaymentUser mockPaymentUser = const PaymentUser(id: 10101010, name: 'Nicholas M.');

List<PaymentUser> mockPaymentUsers = [
  const PaymentUser(id: 10101010, name: 'Nicholas M.'),
  const PaymentUser(id: 10101011, name: 'Alex A.'),
  const PaymentUser(id: 10101012, name: 'Nicholas M.'),
  const PaymentUser(id: 10101013, name: 'Sarah D.'),
  const PaymentUser(id: 10101014, name: 'Omar M.'),
  const PaymentUser(id: 10101015, name: 'Mariam'),
  const PaymentUser(id: 10101016, name: 'Omar'),
  const PaymentUser(id: 10101017, name: 'Henry'),
  const PaymentUser(id: 10101018, name: 'Adam'),
  const PaymentUser(id: 10101019, name: 'Russell'),
  const PaymentUser(id: 10101020, name: 'Peter'),
];