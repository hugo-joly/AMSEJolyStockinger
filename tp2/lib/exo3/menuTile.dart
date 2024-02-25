import 'package:flutter/material.dart';

class MenuTile extends StatefulWidget {
  MenuTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.exercice});

  final String title;
  final String subtitle;
  final Widget exercice;

  @override
  _MenuTileState createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => widget.exercice));
        },
        child: ListTile(
            title: Text(widget.title), subtitle: Text(widget.subtitle)),
      ),
    );
  }
}
