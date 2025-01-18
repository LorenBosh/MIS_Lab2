import 'package:flutter/material.dart';
import 'package:lab2_211084/models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final bool isFavorite;
  final void Function(Joke) onFavorite;

  const JokeCard({
    super.key,
    required this.joke,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              joke.setup,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              joke.punchline,
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => onFavorite(joke),
            ),
          ],
        ),
      ),
    );
  }
}