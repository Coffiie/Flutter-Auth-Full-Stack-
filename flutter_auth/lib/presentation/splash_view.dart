import 'package:flutter/material.dart';
import 'package:flutter_auth/presentation/auth/login/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [],
      child: LoginView(),
    );
  }
}
