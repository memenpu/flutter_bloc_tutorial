import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/src/ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MovieList(),
      )
    );
  }
}
