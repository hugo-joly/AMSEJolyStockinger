import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

math.Random random = new math.Random();

class Tile {
  late int id;
  late String imageURL;
  late Alignment alignment;
  Tile({required this.imageURL, required this.alignment, required this.id});
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

List<Tile> createTileTab(int nbTile, String url) {
  List<Tile> tiles = [];

  double step = 2 / (math.sqrt(nbTile) - 1);
  for (int i = 0; i < nbTile; i++) {
    tiles.add(Tile(
        imageURL: url,
        alignment: Alignment(((i % math.sqrt(nbTile)) * step - 1).toDouble(),
            (i ~/ math.sqrt(nbTile)) * step - 1),
        id: i));
  }

  return tiles;
}

void main() => runApp(new MaterialApp(home: Taquin()));

class Taquin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaquinState();
}

class TaquinState extends State<Taquin> {
  late List<Tile> tiles;
  late int gridSize;
  int emptyTileIndex = 0;
  int compteurDeplacement = 0;

  @override
  void initState() {
    super.initState();
    gridSize = 3; // Initial grid size
    generateTiles('https://picsum.photos/512');
  }

  void generateTiles(String imageUrl) {
    // Ici, vous pouvez remplacer l'URL de l'image par celle que vous souhaitez utiliser
    tiles = createTileTab(gridSize * gridSize, imageUrl);
  }

  String imagePickedFromGallery = '';
  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePickedFromGallery = pickedFile.path;
      setState(() {
        generateTiles(pickedFile.path);
      });
    }
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

  bool isFinish() {
    for (int i = 0; i < tiles.length; i++) {
      if (i != tiles[i].id) {
        return false;
      }
    }
    return true;
  }

  String textDisplayed() {
    if (isFinish()) {
      return ("Gagné !!!");
    } else {
      return ('Déplacements: $compteurDeplacement');
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () {
              getImageFromGallery();
            },
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textDisplayed(),
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
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
                            setState(() => compteurDeplacement++);
                            moveTile(index);
                            if (isFinish()) {
                              const Text(
                                "Gagné !!!",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              );
                            }
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
                if (imagePickedFromGallery != '') {
                  generateTiles(imagePickedFromGallery);
                } else {
                  generateTiles(
                      'https://picsum.photos/512'); // Regenerate tiles when grid size changes
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gridSize.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
