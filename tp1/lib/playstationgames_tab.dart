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
          title: const Text('PlayStation games'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Utilisation de l'icône de retour
            onPressed: () {
              Navigator.pop(context); // Pop de la route actuelle pour revenir à la précédente
            },
          ),
        ),
        body: ListView.builder(
          itemCount: playstationgames.length,
          itemBuilder: (BuildContext context, int index) {
            // Build each ListTile using the object at the corresponding index
            return ListTile(
              title: Text(playstationgames[index].title),
              subtitle:
                  Text('Genre: ${playstationgames[index].genre}\nDescription: ${playstationgames[index].description}'),
              leading: Image.asset(
                playstationgames[index].imageUrl,
                width: 35,
                height: 100,
                fit: BoxFit.fill,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  if (FavoriteService.isInFavorites(playstationgames[index])) {
                    FavoriteService.removeFromFavorites(playstationgames[index]);
                  }
                  else {
                    FavoriteService.addToFavorites(playstationgames[index]);
                  }
                }
              ),
            );
          },
        ),
      ),
    );
  }
}
