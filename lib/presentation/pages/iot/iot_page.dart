import 'package:flutter/material.dart';

class IotPage extends StatefulWidget {
  const IotPage({Key? key}) : super(key: key);

  @override
  _IotPageState createState() => _IotPageState();
}

class _IotPageState extends State<IotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iot Devices', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Iot Page'),
              ],
            ),
          ),
      ),
    );
  }
}