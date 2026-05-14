import 'package:apis_auth_jwt/Helper/help_snackbar.dart';
import 'package:apis_auth_jwt/Login/login_bloc.dart';
import 'package:apis_auth_jwt/Login/login_event.dart';
import 'package:apis_auth_jwt/Login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful")),
              );

              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }

            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "Something went wrong")),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),


                  const SizedBox(height: 30),

                  // Username
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter username";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is LoadingState
                          ? null
                          : () {
                              final username = usernameController.text.trim();
                              final password = passwordController.text.trim();

                              if (username.isEmpty) {
                                HelpSnackBar.showSnack(context, "Username required");
                                return;
                              }

                              if (password.isEmpty) {
                                HelpSnackBar.showSnack(context, "Password required");
                                return;
                              }
                              context
                                  .read<LoginBloc>()
                                  .add(LoginButtonEvent(usernameController.text.trim(), passwordController.text.trim()));
                            },
                      child: state is LoadingState ? const CircularProgressIndicator(color: Colors.red) : const Text("Login"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
