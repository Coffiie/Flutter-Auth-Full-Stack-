import 'package:flutter/material.dart';
import 'package:flutter_auth/application/auth/login/login_bloc.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(() {
          if (state.isAuthenticated) {
            Navigator.pushNamed(context, '/home');
          }
        }, (either) {
          either.fold(
            (l) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l.message)),
            ),
            (r) {},
          );
        });
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: context.watch<LoginBloc>().state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Enter Username'),
                  keyboardType: TextInputType.text,
                  controller: _usernameController,
                  validator: (value) => Username(value ?? '').value.fold(
                        (l) => l.maybeMap(
                          empty: (s) => 'Username cannot be empty',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Enter Password'),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (value) => Password.login(value ?? '').value.fold(
                        (l) => l.maybeMap(
                          empty: (s) => 'Password cannot be empty',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.isSubmitting != current.isSubmitting,
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () => context.read<LoginBloc>().add(
                            LoginEvent.loginPressed(
                              username: Username(_usernameController.text),
                              password:
                                  Password.login(_passwordController.text),
                            ),
                          ),
                      child: const Text('Login'),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: const Text('Register here'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
