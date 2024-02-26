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

class Exo5A extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Fixe'),
        centerTitle: true,
      ),
      body: GridView.builder(
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
