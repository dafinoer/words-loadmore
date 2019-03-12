import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:loadmore/loadmore.dart';

class RandomWord extends StatefulWidget {
  RandomWordState createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWord> {

  List<WordPair> dataWord = [];

  void load(){
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
      ),
      body: _suggestionLoadMore()
    );
  }

  Widget _suggestionLoadMore(){
    return LoadMore(
      onLoadMore: _loadMore,
      delegate: DefaultLoadMoreDelegate(),
      textBuilder: DefaultLoadMoreTextBuilder.english,
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
          itemBuilder: (BuildContext contex, int i){
            return row(dataWord[i]);
          },
          itemCount: dataWord.length,
      ),
    );
  }

  Future<bool> _loadMore() async {
    print('onloadmore');
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Widget row(WordPair word){
    return ListTile(
      leading: new CircleAvatar(
        child: new Text(word.asUpperCase[0]),
        backgroundColor: Colors.black,
      ),
      title: Text(word.asPascalCase),
    );
  }
}
