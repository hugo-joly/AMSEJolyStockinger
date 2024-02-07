class GameModel {
  final String imageUrl;
  final String title;
  final String genre;
  final String description;

  //Constructor
  const GameModel(
    {required this.imageUrl, required this.title, required this.genre, required this.description});
}

const pcgames = [
  GameModel(
    imageUrl: 'assets/imgs/valorant.jpg',
    title: 'Valorant',
    genre: 'FPS',
    description: 'Valo>>>CS',
  ),

  GameModel(
    imageUrl: 'assets/imgs/CSGO2.jpg',
    title: 'CS',
    genre: 'FPS',
    description: 'enorme bouse'
  ),

  GameModel(
    imageUrl: 'assets/imgs/lol.jpg',
    title: 'League Of Legends',
    genre: 'MOBA',
    description: "aspirateur d'âme",
  )
];

const playstationgames = [
    GameModel(
      imageUrl: 'assets/imgs/destruction_allstar.jpg',
      title: 'Destruction All-Star',
      genre: 'Destruction',
      description: 'Destruction'
    ),

  GameModel(
    imageUrl: 'assets/imgs/marvel_s_spider_man_miles_morales.jpg',
    title: 'Spider-Man',
    genre: 'Open World',
    description: "spiderman l'homme araignée",
  )
];