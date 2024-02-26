import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile(double tileSize) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: 1 / tileSize,
            heightFactor: 1 / tileSize,
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

class Exo5B extends StatefulWidget {
  @override
  _Exo5BState createState() => _Exo5BState();
}

class _Exo5BState extends State<Exo5B> {
  double gridSize = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Fixe'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize.toInt(),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              itemCount: tiles.length,
              itemBuilder: (BuildContext context, int index) {
                return createTileWidgetFrom(tiles[index], gridSize);
              },
            ),
          ),
          Slider(
            value: gridSize,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                gridSize = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gridSize.toInt().toString(),
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget createTileWidgetFrom(Tile tile, double size) {
    return InkWell(
      child: tile.croppedImageTile(size),
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

