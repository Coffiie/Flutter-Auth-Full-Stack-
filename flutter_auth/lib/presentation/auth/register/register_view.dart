import 'package:flutter/material.dart';
import 'package:flutter_auth/application/auth/register/register_bloc.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(() {
          if (state.isRegistered) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!')),
            );
            Navigator.pop(context);
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
            autovalidateMode:
                context.watch<RegisterBloc>().state.showErrorMessages
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
                  validator: (value) => Password.register(
                    value ?? '',
                    _confirmPasswordController.text,
                  ).value.fold(
                        (l) => l.maybeMap(
                          empty: (s) => 'Password cannot be empty',
                          notEqual: (s) =>
                              'Password and confirm password should be equal',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Confirm Password'),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  validator: (value) =>
                      Password.register(_passwordController.text, value ?? '')
                          .value
                          .fold(
                            (l) => l.maybeMap(
                              empty: (s) => 'Confirm Password cannot be empty',
                              notEqual: (s) =>
                                  'Password and confirm password should be equal',
                              orElse: () => null,
                            ),
                            (r) => null,
                          ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.isSubmitting != current.isSubmitting,
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () => context.read<RegisterBloc>().add(
                            RegisterEvent.registerPressed(
                              username: Username(_usernameController.text),
                              password: Password.register(
                                _passwordController.text,
                                _confirmPasswordController.text,
                              ),
                            ),
                          ),
                      child: const Text('Register'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
