import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  late String imageURL;
  late Alignment alignment;
  Tile({required this.imageURL, required this.alignment});
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  final double tileSize;

  TileWidget({required this.tile, required this.tileSize});

  @override
  Widget build(BuildContext context) {
    return croppedImageTile(tileSize);
  }

  Widget croppedImageTile(double tileSize) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: tile.alignment,
            widthFactor: 1 / tileSize,
            heightFactor: 1 / tileSize,
            child: Image.network(tile.imageURL),
          ),
        ),
      ),
    );
  }
}

List<Tile> createTileTab(int nbTile) {
  List<Tile> tiles = [];

  double step = 2 / (math.sqrt(nbTile) - 1);
  for (int i = 0; i < nbTile; i++) {
    tiles.add(Tile(
        imageURL: 'https://picsum.photos/512',
        alignment: Alignment(((i % math.sqrt(nbTile)) * step - 1).toDouble(),
            (i ~/ math.sqrt(nbTile)) * step - 1)));
  }

  return tiles;
}

void main() => runApp(new MaterialApp(home: ImagePuzzle()));

class ImagePuzzle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagePuzzleState();
}

class ImagePuzzleState extends State<ImagePuzzle> {
  late List<Tile> tiles;
  late int gridSize;
  int emptyTileIndex = 0;

  @override
  void initState() {
    super.initState();
    gridSize = 3; // Initial grid size
    generateTiles();
  }

  void generateTiles() {
    // Ici, vous pouvez remplacer l'URL de l'image par celle que vous souhaitez utiliser
    tiles = createTileTab(gridSize * gridSize);
  }

  bool? isMoveValid(int index, int emptyTileIndex, int size) {
    int activeRow = emptyTileIndex ~/ size;
    int activeCol = emptyTileIndex % size;
    int possibleRow = index ~/ size;
    int possibleCol = index % size;

    if (activeCol == 0) {
      if (activeRow == 0) {
        return ((possibleCol == activeCol + 1 && possibleRow == activeRow) ||
            (possibleRow == activeRow + 1 && possibleCol == activeCol));
      }
      if (activeRow == size - 1) {
        return ((possibleRow == activeRow - 1 && possibleCol == activeCol) ||
            (possibleCol == activeCol + 1 && possibleRow == activeRow));
      } else {
        return ((possibleRow == activeRow + 1 && possibleCol == activeCol) ||
            (possibleRow == activeRow - 1 && possibleCol == activeCol) ||
            (possibleCol == activeCol + 1 && possibleRow == activeRow));
      }
    } else if (activeCol == size - 1) {
      if (activeRow == 0) {
        return ((possibleCol == activeCol - 1 && possibleRow == activeRow) ||
            (possibleRow == activeRow + 1 && possibleCol == activeCol));
      }
      if (activeRow == size - 1) {
        return ((possibleRow == activeRow - 1 && possibleCol == activeCol) ||
            (possibleCol == activeCol - 1 && possibleRow == activeRow));
      } else {
        return ((possibleRow == activeRow + 1 && possibleCol == activeCol) ||
            (possibleRow == activeRow - 1 && possibleCol == activeCol) ||
            (possibleCol == activeCol - 1 && possibleRow == activeRow));
      }
    } else if (activeRow == 0) {
      if (activeCol >= 1 || activeCol < size - 1) {
        return ((possibleCol == activeCol - 1 && possibleRow == activeRow) ||
            (possibleCol == activeCol + 1 && possibleRow == activeRow) ||
            (possibleRow == activeRow + 1 && possibleCol == activeCol));
      }
    } else if (activeRow == size - 1) {
      if (activeCol >= 1 && activeCol < size - 1) {
        return ((possibleCol == activeCol - 1 && possibleRow == activeRow) ||
            (possibleCol == activeCol + 1 && possibleRow == activeRow) ||
            (possibleRow == activeRow - 1 && possibleCol == activeCol));
      }
    } else {
      return ((possibleCol == activeCol + 1 && possibleRow == activeRow) ||
          (possibleCol == activeCol - 1 && possibleRow == activeRow) ||
          (possibleRow == activeRow + 1 && possibleCol == activeCol) ||
          (possibleRow == activeRow - 1 && possibleCol == activeCol));
    }
  }

  void moveTile(int index) {
    setState(() {
      Tile temp = tiles[emptyTileIndex];
      tiles[emptyTileIndex] = tiles[index];
      tiles[index] = temp;
      emptyTileIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Puzzle'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (BuildContext context, int index) {
                  if (index == emptyTileIndex) {
                    return Container();
                  } else {
                    return GestureDetector(
                        onTap: () {
                          if (isMoveValid(index, emptyTileIndex, gridSize)!) {
                            moveTile(index);
                          }
                        },
                        child: TileWidget(
                            tile: tiles[index], tileSize: gridSize.toDouble()));
                  }
                }),
          ),
          Slider(
            value: gridSize.toDouble(),
            min: 2,
            max: 10,
            divisions: 8,
            onChanged: (value) {
              setState(() {
                gridSize = value.toInt();
                generateTiles(); // Regenerate tiles when grid size changes
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gridSize.toString(),
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
