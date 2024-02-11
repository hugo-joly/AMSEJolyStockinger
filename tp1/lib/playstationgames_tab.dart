import 'package:flutter/material.dart';
import 'package:tp1/model.dart';

class PlayStationGamesTab extends StatelessWidget {
  // Sample list of objects
  const PlayStationGamesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of PlayStation games'),
        ),
        body: ListView.builder(
          itemCount: playstationgames.length,
          itemBuilder: (BuildContext context, int index) {
            // Build each ListTile using the object at the corresponding index
            return ListTile(
              title: Text(playstationgames[index].title),
              subtitle:
                  Text('Description: ${playstationgames[index].description}'),
              leading: Image.asset(
                playstationgames[index].imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
