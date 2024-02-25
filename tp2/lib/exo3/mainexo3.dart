import 'package:flutter/material.dart';
import '../exo1/mainexo1.dart';
import '../exo2/mainexo2A.dart';
import '../exo4/mainexo4.dart';
import 'menuTile.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const String _title = 'Menu exo 3';
  static const Color _backgroundcolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          backgroundColor: _backgroundcolor,
        ),
        body: ListView(children: [
          MenuTile(
              title: "Exercice 1",
              subtitle: "Afficher une image",
              exercice: const Exo1()),
          MenuTile(
              title: "Exercice 2A",
              subtitle: "Sliders",
              exercice: const Exo2A()),
          MenuTile(
              title: "Exercice 4",
              subtitle: "Tile",
              exercice: const DisplayTileWidget())
        ]));
  }
}
