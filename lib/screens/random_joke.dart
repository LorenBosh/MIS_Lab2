import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/joke.dart';
import '../services/api_services.dart';
import '../widgets/jokes/joke_card.dart';

class RandomJoke extends StatefulWidget{
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();

}

class _RandomJokeState extends State<RandomJoke>{
  Joke? joke;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRandomJoke();
  }

  Future<void> fetchRandomJoke() async {
    ApiService.getRandomJoke().then((response) {
      var data = json.decode(response.body);
      setState(() {
        joke = Joke.fromJson(data as Map<String, dynamic>);
        isLoading=false;
      });
    }).catchError((error) {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke of the Day'),
        backgroundColor: Colors.pink[100],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : joke == null
          ? const Center(
        child: Text(
          "Failed to load joke. Please try again.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Center(child: JokeCard(joke: joke!)), // Use JokeCard when joke is loaded
    );
  }
}