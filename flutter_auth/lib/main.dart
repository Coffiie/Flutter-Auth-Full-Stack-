import 'package:flutter/material.dart';
import 'package:flutter_auth/application/auth/login/login_bloc.dart';
import 'package:flutter_auth/application/auth/register/register_bloc.dart';
import 'package:flutter_auth/infra/auth/datasource/auth_remote.dart';
import 'package:flutter_auth/infra/auth/repo/auth_repo.dart';
import 'package:flutter_auth/presentation/auth/login/login_view.dart';
import 'package:flutter_auth/presentation/auth/register/register_view.dart';
import 'package:flutter_auth/presentation/home/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const HomeView(),
        '/login': (context) => BlocProvider(
              create: (context) => LoginBloc(
                authRepo: AuthRepository(
                  authRemoteDataSource: AuthRemoteDataSource(),
                ),
              ),
              child: LoginView(),
            ),
        '/register': (context) => BlocProvider(
              create: (context) => RegisterBloc(
                authRepo: AuthRepository(
                  authRemoteDataSource: AuthRemoteDataSource(),
                ),
              ),
              child: RegisterView(),
            ),
      },
      initialRoute: '/login',
    );
  }
}
