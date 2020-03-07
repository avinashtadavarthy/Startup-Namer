import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer_sample/savedItems.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Startup Name Generator', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  void _pushSaved() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SavedItems(items:_saved)));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final int index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18)),
      onTap: () {
        setState(() {
          if (!alreadySaved) {
            _saved.add(pair);
          } else {
            _saved.remove(pair);
          }
        });
      },
      trailing: alreadySaved
          ? Icon(Icons.favorite, color: Colors.redAccent)
          : Icon(Icons.favorite_border, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Startup Name Generator",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
