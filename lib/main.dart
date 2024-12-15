import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_bloc.dart';
import 'package:launder_app/presentation/blocs/user/user_event.dart';
import 'package:launder_app/presentation/pages/auth/login_page.dart';
import 'package:launder_app/presentation/pages/auth/register_page.dart';
import 'package:launder_app/presentation/pages/main_page.dart';
import 'package:launder_app/presentation/pages/outlet/detail_outlet_page.dart';
import 'package:launder_app/presentation/pages/splash_page.dart';
import 'package:launder_app/services/user_service.dart';
import 'package:launder_app/utils/local_storage/auth_local_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserBloc(userService: UserService())..add(UserGetEvent()))
        ],
        child: MaterialApp(
          title: 'Launder App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          home: FutureBuilder(
              future: AuthLocalStorage().get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SplashPage();
              }
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/splash': (context) => const SplashPage(),
            '/home': (context) => MainPage(),
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/outlet/detail': (context) => DetailOutletPage()
          },
        )
    );
  }
}
