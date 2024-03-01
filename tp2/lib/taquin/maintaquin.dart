//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

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
  bool started = false;
  int selectedDifficulty = 1;
  String randomImage = 'https://picsum.photos/512';
  String imagePickedFromGallery = '';

  @override
  void initState() {
    super.initState();
    gridSize = 3; // Initial grid size
    generateTiles(randomImage);
  }

  void generateTiles(String imageUrl) {
    // Ici, vous pouvez remplacer l'URL de l'image par celle que vous souhaitez utiliser
    tiles = createTileTab(gridSize * gridSize, imageUrl);
  }

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

  bool isFinished() {
    for (int i = 0; i < tiles.length; i++) {
      if (i != tiles[i].id) {
        return false;
      }
    }
    return true;
  }

  String textDisplayed() {
    if (started) {
      if (isFinished()) {
        return ("Gagné !!!");
      } else {
        return ('Déplacements: $compteurDeplacement');
      }
    } else {
      return ("À vous de jouer !");
    }
  }

  math.Random random = new math.Random();

  String generateRandomImageUrl() {
    // Generate a random number to append to the URL
    int randomNumber =
        random.nextInt(1000); // You can adjust the range as needed
    // Construct the URL with the random number
    randomImage = 'https://picsum.photos/512?v=$randomNumber';
    return randomImage;
  }

  void moveTile(int index) {
    setState(() {
      Tile temp = tiles[emptyTileIndex];
      tiles[emptyTileIndex] = tiles[index];
      tiles[index] = temp;
      emptyTileIndex = index;
    });
  }

  void shuffleTiles(int diff) {
    int nbCoup = 200 * diff * (gridSize);
    int i = 1;
    int max = tiles.length;

    while (i < nbCoup) {
      List<int> possibleMove = [];
      emptyTileIndex = random.nextInt(gridSize);
      for (int j = 0; j < max; j++) {
        if (isMoveValid(j, emptyTileIndex, gridSize)!) {
          possibleMove.add(j);
        }
      }

      int newIndice = possibleMove[random.nextInt(possibleMove.length)];
      tiles.insert(newIndice, tiles.removeAt(emptyTileIndex));
      emptyTileIndex = newIndice;
      i++;
    }

    /*

    if (diff == 0) {
    } else {
      int nbCoup = 2 * diff * (gridSize);
      int i = 1;
      int max = tiles.length;

      while (i < nbCoup) {
        List<int> possibleMove = [];
        int randomNumber = 1 + random.nextInt(max - 2);
        for (int j = 0; j < max; j++) {
          if (isMoveValid(j, randomNumber, gridSize)!) {
            possibleMove.add(j);
          }
        }
        int newIndice = possibleMove[random.nextInt(possibleMove.length)];
        tiles.insert(newIndice, tiles.removeAt(randomNumber));
        i++;
      }

      */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taquin'),
        centerTitle: true,
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
                  //shuffleTiles(1);
                  if (index == emptyTileIndex) {
                    return Container();
                  } else {
                    return GestureDetector(
                        onTap: !started
                            ? null
                            : () {
                                if (isMoveValid(
                                    index, emptyTileIndex, gridSize)!) {
                                  setState(() => compteurDeplacement++);
                                  moveTile(index);
                                }
                              },
                        child: TileWidget(
                            tile: tiles[index], tileSize: gridSize.toDouble()));
                  }
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.cached_rounded),
                    onPressed: started
                        ? null
                        : () {
                            setState(() {
                              generateTiles(generateRandomImageUrl());
                            });
                          },
                  ),
                  Text("Random"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: started
                        ? Icon(Icons.stop_circle)
                        : Icon(Icons.play_circle),
                    onPressed: () {
                      setState(() {
                        if (!started) {
                          shuffleTiles(selectedDifficulty);
                          started = true;
                        } else {
                          if (imagePickedFromGallery != '') {
                            generateTiles(imagePickedFromGallery);
                          } else {
                            generateTiles(randomImage);
                          }
                          compteurDeplacement = 0;
                          emptyTileIndex = 0;
                          started = false;
                        }
                      });
                    },
                  ),
                  Text(started ? "Stop" : "Start"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: started
                        ? null
                        : () {
                            getImageFromGallery();
                          },
                  ),
                  Text("Gallery"),
                ],
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10, 10, 10),
                child: Text(
                  'Difficulty :',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              for (int i = 1; i < 4; i++)
                ElevatedButton(
                  onPressed: started
                      ? null
                      : () {
                          setState(() {
                            selectedDifficulty = i;
                          });
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            i == selectedDifficulty) {
                          return Colors.deepPurple;
                        }
                        return const Color.fromARGB(118, 104, 58, 183);
                      },
                    ),
                  ),
                  child: Text('$i'),
                ),
            ],
          ),
          _SliderGridSize(
            value: gridSize.toDouble(),
            onChanged: (value) {
              setState(() {
                gridSize = value.toInt();
                if (imagePickedFromGallery != '') {
                  generateTiles(imagePickedFromGallery);
                } else {
                  generateTiles(randomImage);
                }
              });
            },
            label: "Grid Size :",
          ),
        ],
      ),
    );
  }

  Widget _SliderGridSize({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 20),
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: value,
            min: 2,
            max: 10,
            divisions: 8,
            onChanged: started ? null : onChanged,
          ),
        ),
      ],
    );
  }
}
