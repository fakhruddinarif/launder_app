import 'package:flutter/material.dart';

class LaunderNotFound extends StatelessWidget {
  const LaunderNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/no_load_data.png'),),
    );
  }
}