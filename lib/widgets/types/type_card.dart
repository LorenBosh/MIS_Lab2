import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget{
  final String type;

  const TypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
      Navigator.pushNamed(
        context,
        '/jokes',
        arguments: type,
      );
    },
      child:Card(
      margin: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          type,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }

}