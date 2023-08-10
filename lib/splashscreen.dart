import 'package:flutter/material.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
