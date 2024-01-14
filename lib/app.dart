import 'package:block_firebase/app_view.dart';
import 'package:block_firebase/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
                  myUserRepository: userRepository,
                ))
      ],
      child: const MyAppView(),
    );
  }
}
