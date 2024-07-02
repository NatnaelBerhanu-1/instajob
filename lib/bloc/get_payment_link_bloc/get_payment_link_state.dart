import 'dart:math';

import 'package:equatable/equatable.dart';

class GetPaymentLinkState extends Equatable {
  const GetPaymentLinkState();
  @override
  List<Object?> get props => [];
}

class GetPaymentLinkInitialState extends GetPaymentLinkState {}

class GetPaymentLinkLoading extends GetPaymentLinkState {
  const GetPaymentLinkLoading();
}

class GetPaymentLinkLoaded extends GetPaymentLinkState {
  final String linkUrl;

  const GetPaymentLinkLoaded({
    required this.linkUrl,
  });

  @override
  List<Object?> get props => [linkUrl, Random()];
}

class GetPaymentLinkErrorState extends GetPaymentLinkState {
  final String message;

  const GetPaymentLinkErrorState({
    required this.message,
  });
}
