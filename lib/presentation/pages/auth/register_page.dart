import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_event.dart';
import 'package:launder_app/presentation/blocs/user/user_state.dart';
import 'package:launder_app/presentation/widgets/TextField.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({Key? key}) : super(key: key);

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
                          const Text(
                            "Please enter your details for registration.",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(height: 16,),
                          LaunderTextFormField(
                              labelText: 'Name',
                              hintText: 'Enter your name',
                              controller: _nameController,
                              isRequired: true,
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
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              controller: _emailController,
                              isRequired: true,
                          ),
                          const SizedBox(height: 16,),
                          LaunderTextFormField(
                              labelText: 'Phone',
                              hintText: 'Enter your phone',
                              controller: _phoneController,
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
                          const SizedBox(height: 24,),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserBloc>().add(UserRegisterEvent(
                                  name: _nameController.text,
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                ));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
              )
            ),
          );
        },
        listener: (context, state) {
          if (state is UserRegister) {
            Navigator.pushReplacementNamed(context, '/login');
          }
          if (state is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                )
            );
          }
        }
    );
  }
}