import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: 1 / 3,
            heightFactor: 1 / 3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

List<Tile> tiles = [
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(-1, -1)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, -1)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(1, -1)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(-1, 0)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(1, 0)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(-1, 1)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 1)),
  Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(1, 1))
];

class Exo5B extends StatelessWidget {
  const Exo5B({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: const SquaredImage(),
    );
  }
}

class SquaredImage extends StatefulWidget {
  const SquaredImage({super.key});

  @override
  State<SquaredImage> createState() => _SquaredImageState();
}

class _SquaredImageState extends State<SquaredImage> {
  int _currentSliderSize = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Fixe'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _currentSliderSize,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              itemCount: tiles.length,
              itemBuilder: (BuildContext context, int index) {
                return createTileWidgetFrom(tiles[index]);
              },
            ),
            _SliderSize(
              value: _currentSliderSize,
              onChanged: (double value) {
                setState(() {
                  _currentSliderSize = value;
                });
              },
              label: 'Rotate X:',
            ),
          ],
        ));
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

Widget _SliderSize({
  required double value,
  required ValueChanged<double> onChanged,
  required String label,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(label),
      const SizedBox(width: 20),
      Expanded(
        child: Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 10,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
