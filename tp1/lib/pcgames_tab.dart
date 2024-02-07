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
    imageUrl: '',
    title: 'Valorant',
    genre: 'FPS',
    description: 'Valo>>>CS',
  ),

  GameModel()
]