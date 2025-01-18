import 'package:flutter/material.dart';

import '../models/joke.dart';
import '../widgets/jokes/joke_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;

  const FavoritesScreen({super.key, required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.pink[100],
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
        child: Text(
          "No favorite jokes yet.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return JokeCard(
            joke: joke,
            isFavorite: true,
            onFavorite: (Joke joke) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This joke is already in your favorites')),
              );
            },
          );
        },
      ),
    );
  }
}