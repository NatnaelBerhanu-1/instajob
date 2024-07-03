import 'package:equatable/equatable.dart';

class CheckKycAvailabilityState extends Equatable {
  const CheckKycAvailabilityState();
  @override
  List<Object?> get props => [];
}

class CheckKycAvailabilityInitialState extends CheckKycAvailabilityState {}

class CheckKycAvailabilityLoading extends CheckKycAvailabilityState {
  const CheckKycAvailabilityLoading();
}

class CheckKycAvailabilityFound extends CheckKycAvailabilityState {
  const CheckKycAvailabilityFound(); //TODO: consider receiving the found kyc data for prefill? (if needed for edit feature)

  @override
  List<Object?> get props => [];
}


class CheckKycAvailabilityNotFound extends CheckKycAvailabilityState {
  const CheckKycAvailabilityNotFound();

  @override
  List<Object?> get props => [];
}

class CheckKycAvailabilityErrorState extends CheckKycAvailabilityState {
  final String message;

  const CheckKycAvailabilityErrorState({
    required this.message,
  });
}
