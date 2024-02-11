import 'package:flutter/material.dart';
import 'package:tp1/model.dart';

class PcGamesTab extends StatelessWidget {
  // Sample list of objects
  const PcGamesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of PC games'),
        ),
        body: ListView.builder(
          itemCount: pcgames.length,
          itemBuilder: (BuildContext context, int index) {
            // Build each ListTile using the object at the corresponding index
            return ListTile(
              title: Text(pcgames[index].title),
              subtitle: Text('Description: ${pcgames[index].description}'),
              leading: Image.asset(
                pcgames[index].imageUrl,
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
