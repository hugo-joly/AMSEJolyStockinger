import 'package:flutter/material.dart';

void main() {
  runApp(const Exo1());
}

class Exo1 extends StatelessWidget {
  const Exo1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Image.network(
        'https://picsum.photos/512/1024',
        width: 150.0,
        height: 100.0,
      ),
    );
  }
}