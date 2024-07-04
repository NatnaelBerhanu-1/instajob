import 'package:equatable/equatable.dart';
import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_data.dart';

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
  const CheckKycAvailabilityFound({required this.data}); //TODO: consider receiving the found kyc data for prefill? (if needed for edit feature)
  final FetchedKycData data;

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
