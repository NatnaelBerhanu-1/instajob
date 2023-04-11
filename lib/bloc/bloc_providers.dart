import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/global_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:insta_job/di_container.dart' as di;

final List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (_) => di.sl<AuthCubit>()),
  BlocProvider(create: (_) => di.sl<IndexBloc>()),
  BlocProvider(create: (_) => di.sl<ValidationCubit>()),
];
