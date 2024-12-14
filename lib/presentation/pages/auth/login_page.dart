import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_event.dart';
import 'package:launder_app/presentation/blocs/user/user_state.dart';
import 'package:launder_app/presentation/widgets/TextField.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24,),
                          Image.asset('assets/images/logo.jpg', width: 84, height: 84,),
                          const SizedBox(height: 16,),
                          RichText(
                            text: const TextSpan(
                              text: "Please enter your ",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: "username", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: " and "),
                                TextSpan(text: "password", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: " for login."),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                          LaunderTextFormField(
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            controller: _usernameController,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16,),
                          LaunderTextFormField(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            obscureText: true,
                            controller: _passwordController,
                            isRequired: true,
                          ),
                          const SizedBox(height: 8,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Forgot Password?', style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(height: 24,),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<UserBloc>(context).add(UserLoginEvent(username: _usernameController.text, password: _passwordController.text));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16,),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login-outlet');
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16,),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: const Center(
                                child: Text('Login as an Outlet', style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? ", style: TextStyle(color: Colors.black, fontSize: 14)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text('Register', style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is UserSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red));
          }
        }
    );
  }
}