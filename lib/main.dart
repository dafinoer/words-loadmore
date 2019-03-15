import 'package:flutter/material.dart';
import 'package:word/random-word.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter First Apps',
      theme: ThemeData(
        primaryColor: Colors.amberAccent
      ),
      home: RandomWord()
    );
  }
}
