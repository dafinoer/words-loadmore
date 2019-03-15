import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:loadmore/loadmore.dart';

class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWord> {
  final List<WordPair> dataWord = [];
  Set<WordPair> _saveData = Set<WordPair>();

  void load() {
    setState(() {
      dataWord.addAll(generateWordPairs().take(10));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Text'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.list),
              onPressed: _pushSave,
            )
          ],
        ),
        body: _suggestionLoadMore());
  }

  Widget _suggestionLoadMore() {
    return LoadMore(
      onLoadMore: _loadMore,
      delegate: DefaultLoadMoreDelegate(),
      textBuilder: DefaultLoadMoreTextBuilder.english,
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext contex, int i) {
          if (i.isOdd) return Divider();
          return _row(dataWord[i]);
        },
        itemCount: dataWord.length,
      ),
    );
  }


  Widget _row(WordPair pair){
    final bool data = _saveData.contains(pair);

    return ListTile(
      leading: CircleAvatar(
        child: Text(pair.asPascalCase[0]),
        backgroundColor: Colors.black,
      ),
      title: Text(
        pair.asCamelCase,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        data ? Icons.favorite : Icons.favorite_border,
        color: data ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (data) {
            _saveData.remove(pair);
          } else {
            _saveData.add(pair);
          }
        });
      },
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  void _pushSave(){
    print(_saveData);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saveData.map((WordPair pair){
            return ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(pair.asPascalCase),
            );
          });
          List<Widget> divided = ListTile.divideTiles(
            context: context, 
            tiles: tiles,
            color: Colors.black,
            ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved'),
            ),
            body: ListView(children: divided,),
          );
        }
      )
    );
  }
}