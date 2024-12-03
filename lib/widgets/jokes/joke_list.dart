import 'package:flutter/material.dart';
import 'package:lab2_211084/models/joke.dart';

import 'joke_card.dart';

class JokeList extends StatelessWidget {
  final List<Joke> jokes;

  const JokeList({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];
        return JokeCard(joke: joke);
      },
    );
  }
}