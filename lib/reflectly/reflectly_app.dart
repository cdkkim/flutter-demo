import 'package:flutter/material.dart';

class ReflectlyApp extends StatefulWidget {
  const ReflectlyApp({Key? key}) : super(key: key);

  @override
  _ReflectlyAppState createState() => _ReflectlyAppState();
}

class _ReflectlyAppState extends State<ReflectlyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reflectly'),
      ),
      body: Stack(
        children: [

        ],
      ),
    );
  }
}
