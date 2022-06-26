import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup name generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Startup name generator',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
              fontFamily: "RobotoMono",
              color: Color.fromARGB(255, 67, 5, 255),
              fontStyle: FontStyle.normal,
              fontSize: 25,
            ),
          ),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(
      fontSize: 20,
      color: Color.fromARGB(224, 68, 2, 209),
      letterSpacing: 2,
      decoration: TextDecoration.underline,
      fontFamily: ' Raleway',
      backgroundColor: Color.fromARGB(255, 238, 255, 198));
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        final alreadySaved = _saved.contains(_suggestions[index]);
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              } else {
                _saved.add(_suggestions[index]);
              }
            });
          },
        );
      },
    );
  }
}
