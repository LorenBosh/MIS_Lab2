import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab2_211084/screens/jokes_from_type.dart';
import 'package:lab2_211084/services/api_services.dart';
import 'package:lab2_211084/widgets/types/type_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getJokeTypes();
  }

  void getJokeTypes() async {
    ApiService.getJokeTypes().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        types = data.cast<String>();
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
        backgroundColor: Colors.pink[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              Navigator.pushNamed(context, '/random-joke');
            },
          ),
        ],
      ),
      body: types.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : TypeList(types: types),
    );
  }
}
