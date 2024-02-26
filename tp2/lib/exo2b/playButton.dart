import 'package:flutter/material.dart';

class ButtonActionPlay extends StatefulWidget {
  const ButtonActionPlay(
      {Key? key,
      required this.startAnimation,
      required this.stopAnimation,
      required this.state})
      : super(key: key);

  final bool state;
  final Function()? stopAnimation;
  final Function()? startAnimation;

  @override
  _ButtonActionPlayState createState() => _ButtonActionPlayState();
}

class _ButtonActionPlayState extends State<ButtonActionPlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: widget.state ? widget.stopAnimation : widget.startAnimation,
        tooltip: "Start Automatic animation",
        child: Icon(widget.state ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
