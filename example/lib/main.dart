import 'package:flutter/material.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Icon Display'),
      ),
      body: const Center(child: NativeAppIconWidget()),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyHomePage(),
  ));
}
