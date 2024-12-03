import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2_211084/widgets/types/type_card.dart';

class TypeList extends StatelessWidget{
  final List<String> types;

  const TypeList({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: types.length,
      itemBuilder: (context, index) {
        return TypeCard(type: types[index]);
      },
    );
  }


}