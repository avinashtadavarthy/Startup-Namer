import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {

  Set<WordPair> items;
  SavedItems({this.items});

  Widget _renderListOfSaved(BuildContext context) {
    final Iterable<ListTile> tiles = items.map(
      (WordPair pair) {
        return ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16),),
        );
      }
    );

    final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

    return ListView(children: divided);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Saved Items',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('View Saved Items', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body: _renderListOfSaved(context),
      ),
    );
  }
}