import 'package:flutter/material.dart';
import 'package:tp1/model.dart';
import 'package:provider/provider.dart';

class FavouritesTab extends StatelessWidget {
  // Sample list of objects
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back), // Utilisation de l'icône de retour
          onPressed: () {
            Navigator.pop(
                context); // Pop de la route actuelle pour revenir à la précédente
          },
        ),
      ),
      body: Consumer<FavoriteService>(
        builder: (context, favoriteService, child) {
          return ListView.builder(
            itemCount: favoriteService.favourites.length,
            itemBuilder: (BuildContext context, int index) {
                final favoriteService = Provider.of<FavoriteService>(context, listen: false);
              // Build each ListTile using the object at the corresponding index
              return ListTile(
                title: Text(favoriteService.favourites[index].title),
                subtitle: Text(
                  'Genre: ${favoriteService.favourites[index].genre}\nDescription: ${favoriteService.favourites[index].description}',
                ),
                leading: Image.asset(
                  favoriteService.favourites[index].imageUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
