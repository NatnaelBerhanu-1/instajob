import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/attachment_download_cubit/attachment_download_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/banking_info_bloc/add_banking_info/add_banking_info_cubit.dart';
import 'package:insta_job/bloc/cancel_interview_schedule_cubit/cancel_interview_schedule_cubit.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/end_interview_call_cubit/end_interview_call_cubit.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:insta_job/bloc/generated_questions/get_generated_initial_questions_bloc.dart';
import 'package:insta_job/bloc/get_declined_job_position/get_denied_job_poision_bloc.dart';
import 'package:insta_job/bloc/get_hired_job_position/get_hired_candidates_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/interview_recording_cubit/interview_recording_cubit.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_cubit.dart';
import 'package:insta_job/bloc/interview_transcription_cubit/interview_transcription_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/mask_resumes_cubit/mask_resumes_cubit.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_details_cubit/resume_details_cubit.dart';
import 'package:insta_job/bloc/upload_kyc_bloc/upload_kyc_cubit.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/di_container.dart' as di;
import 'package:provider/single_child_widget.dart';

import 'bottom_bloc/bottom_bloc.dart';

final List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (_) => di.sl<AuthCubit>()),
  BlocProvider(create: (_) => di.sl<GlobalCubit>()),
  BlocProvider(create: (_) => di.sl<BottomBloc>()),
  BlocProvider(create: (_) => di.sl<ValidationCubit>()),
  BlocProvider(create: (_) => di.sl<CompanyBloc>()),
  BlocProvider(create: (_) => di.sl<PickImageCubit>()),
  BlocProvider(create: (_) => di.sl<JobPositionBloc>()),
  BlocProvider(create: (_) => di.sl<FeedBackAndAutoMsgBloc>()),
  BlocProvider(create: (_) => di.sl<ResumeBloc>()),
  BlocProvider(create: (_) => di.sl<LocationCubit>()),
  // BlocProvider(create: (_) => di.sl<AgoraBloc>()),
  BlocProvider(create: (_) => di.sl<CareerLearningBloc>()),
  BlocProvider(create: (_) => di.sl<AttachmentDownloadCubit>()),
  BlocProvider(create: (_) => di.sl<MaskResumesCubit>()),
  BlocProvider(create: (_) => di.sl<InterviewScheduleCubit>()),
  BlocProvider(create: (_) => di.sl<CancelInterviewScheduleCubit>()),
  BlocProvider(create: (_) => di.sl<ResumeDetailsCubit>()),
  BlocProvider(create: (_) => di.sl<GetDeniedJobPositionCubit>()),
  BlocProvider(create: (_) => di.sl<InterviewRecordingCubit>()),
  BlocProvider(create: (_) => di.sl<EndInterviewCallScheduleCubit>()),
  BlocProvider(create: (_) => di.sl<InterviewTranscriptionCubit>()),
  BlocProvider(create: (_) => di.sl<GetHiredCandidatesCubit>()),
  BlocProvider(create: (_) => di.sl<AddBankingInfoCubit>()),
  BlocProvider(create: (_) => di.sl<UploadKycCubit>()),
  BlocProvider(create: (_) => di.sl<GetGeneratedInitialQuestionsCubit>()),
  BlocProvider(create: (_) => di.sl<CheckKycAvailabilityCubit>()),
];
