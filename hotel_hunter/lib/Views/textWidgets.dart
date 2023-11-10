import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget{

  final String text;

  const AppBarText({Key? key, required this.text}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sign Up Page',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
      )
    );


    
    throw UnimplementedError();
  }

}