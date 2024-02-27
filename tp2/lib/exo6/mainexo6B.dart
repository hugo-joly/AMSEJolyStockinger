import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  late Color color;
  late int id;
  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}

void main() => runApp(new MaterialApp(home: PositionedTilesMoving()));

class PositionedTilesMoving extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTilesMoving> {
  List<TileWidget> tiles =
      List<TileWidget>.generate(9, (index) => TileWidget(Tile.randomColor()));

  int emptyTileIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
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
            if (index == emptyTileIndex) {
              return Container();
            } else {
              return GestureDetector(
                  onTap: () {
                    if (isAdjacent(index, emptyTileIndex, 3)!) {
                      moveTile(index);
                    }
                  },
                  child: tiles[index]);
            }
          }),
    );
  }

  bool? isAdjacent(int index, int emptyTileIndex, int size) {
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
      TileWidget temp = tiles[emptyTileIndex];
      tiles[emptyTileIndex] = tiles[index];
      tiles[index] = temp;
      emptyTileIndex = index;
    });
  }
}
