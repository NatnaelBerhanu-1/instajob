import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
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
];
