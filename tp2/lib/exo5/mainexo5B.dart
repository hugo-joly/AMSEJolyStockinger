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
  double _currentSliderSize = 0;
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
                crossAxisCount: 3,
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
          min: 0,
          max: 2 *
              3.14, // Vous pouvez ajuster la plage en fonction de vos besoins
          divisions: 100,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
