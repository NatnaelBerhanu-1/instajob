import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/di_container.dart' as di;
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (_) => di.sl<AuthCubit>()),
  BlocProvider(create: (_) => di.sl<GlobalCubit>()),
  BlocProvider(create: (_) => di.sl<ValidationCubit>()),
  BlocProvider(create: (_) => di.sl<CompanyBloc>()),
  BlocProvider(create: (_) => di.sl<PickImageCubit>()),
];
