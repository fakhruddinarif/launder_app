import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_event.dart';
import 'package:launder_app/presentation/blocs/user/user_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<UserBloc>().add(UserLogoutEvent());
                  },
                  child: const Text('Logout'),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is UserSuccess) {
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
      ),
    );
  }
}