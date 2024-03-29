import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/model.dart';

import 'pcgames_tab.dart';
import 'playstationgames_tab.dart';
import 'favourites_tab.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Médiathèque',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeRoute(title: 'Mediathèque'),
        '/second': (context) => const PcGamesTab(),
        '/third': (context) => const PlayStationGamesTab(),
        '/fourth': (context) => const FavouritesTab(),
      },
    );
  }
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0), // Marge autour du conteneur
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, double.infinity), // Taille minimale du bouton
                    textStyle: const TextStyle(fontSize: 30.0), // Taille du texte
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text('PC Games'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, double.infinity),
                    textStyle: const TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/third');
                  },
                  child: const Text('Playstation Games'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, double.infinity),
                    textStyle: const TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fourth');
                  },
                  child: const Text('Favourites'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


