import 'package:flutter/material.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Icon Display'),
      ),
      body: Center(child: NativeAppIconWidget()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
