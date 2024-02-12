import 'package:flutter/material.dart';
import 'package:tp1/model.dart';
import 'package:provider/provider.dart';

class PlayStationGamesTab extends StatelessWidget {
  const PlayStationGamesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayStation games'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<FavoriteService>(
        builder: (context, favoriteService, child) {
          return ListView.builder(
            itemCount: playstationgames.length,
            itemBuilder: (BuildContext context, int index) {
              final game = playstationgames[index];
              final favoriteService = Provider.of<FavoriteService>(context, listen: false);
              return ListTile(
                title: Text(game.title),
                subtitle: Text('Genre: ${game.genre}\nDescription: ${game.description}'),
                leading: Image.asset(
                  game.imageUrl,
                  width: 35,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                trailing: IconButton(
                  icon: Icon(favoriteService.isInFavorites(game) ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    if (favoriteService.isInFavorites(game)) {
                      favoriteService.removeFromFavorites(game);
                    } else {
                      favoriteService.addToFavorites(game);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
