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
            widthFactor: 1/3,
            heightFactor: 1/3,
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

class Exo5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display a Tile as a Cropped Image'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns in the grid
          mainAxisSpacing: 4.0, // Spacing between rows
          crossAxisSpacing: 4.0, // Spacing between columns
          childAspectRatio: 1.0, // Aspect ratio of each grid item (width / height)
        ),
        itemCount: tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return createTileWidgetFrom(tiles[index]);
        },
      ),
    );
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

