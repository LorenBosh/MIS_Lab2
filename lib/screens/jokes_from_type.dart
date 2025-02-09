import 'package:flutter/material.dart';
import 'package:lab2_211084/models/joke.dart';

import '../services/api_services.dart';
import '../widgets/jokes/joke_list.dart';

class JokesFromType extends StatefulWidget {
  final List<Joke> jokes;
  final void Function(Joke) onFavorite;

  const JokesFromType({
    super.key,
    required this.jokes,
    required this.onFavorite,
  });


  @override
  State<JokesFromType> createState() => _JokesState();
}

class _JokesState extends State<JokesFromType> {
  late String jokeType;
  List<Joke> jokes = [];
  late final void Function(Joke) onFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    jokeType = arguments.toString();
    if (jokeType.isNotEmpty) getJokes(jokeType);
  }

  Future<void> getJokes(String jokeType) async {
    try {
      final data = await ApiService.getAllJokesFromType(jokeType);
      setState(() {
        jokes = data.map<Joke>((json) => Joke.fromJson(json)).toList();
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$jokeType jokes'),
          backgroundColor: Colors.pink[100],
        ),
        body: jokes.isEmpty
            ? const Text(
                "Jokes loading",
                style: TextStyle(fontSize: 18),
              )
            : JokeList(
            jokes: jokes,
            onFavorite: widget.onFavorite,
        ));
  }
}
