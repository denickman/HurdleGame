

import 'package:flutter/material.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() {
   return _WordHurdlePageState();
  }
}

class _WordHurdlePageState extends State<WordHurdlePage> {

    @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text('Hurdle App'),
    ),
    body: Center(),
   );
  }
}
