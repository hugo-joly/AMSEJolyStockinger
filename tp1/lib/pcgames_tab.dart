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
          title: const Text('PC games'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Utilisation de l'icône de retour
            onPressed: () {
              Navigator.pop(context); // Pop de la route actuelle pour revenir à la précédente
            },
          ),
        ),
        body: ListView.builder(
          itemCount: pcgames.length,
          itemBuilder: (BuildContext context, int index) {
            // Build each ListTile using the object at the corresponding index
            return ListTile(
              title: Text(pcgames[index].title),
              subtitle: Text('Genre: ${pcgames[index].genre}\nDescription: ${pcgames[index].description}'),
              leading: Image.asset(
                pcgames[index].imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            );
          },
        ),
      ),
    );
  }
}
