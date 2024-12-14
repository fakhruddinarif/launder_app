import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is UserFailure) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/logo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}