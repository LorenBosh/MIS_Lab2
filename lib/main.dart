import 'package:flutter/material.dart';
import 'package:lab2_211084/screens/home.dart';
import 'package:lab2_211084/screens/jokes_from_type.dart';
import 'package:lab2_211084/screens/random_joke.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/jokes': (context) => const JokesFromType(),
        '/random-joke': (context) => const RandomJoke(),
      },
    );
  }

}

