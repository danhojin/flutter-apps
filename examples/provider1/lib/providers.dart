import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Words extends ChangeNotifier {
  var _words = <WordPair>[];

  WordPair operator [](int index) {
    if (_words.length <= index) {
      _words.addAll(generateWordPairs().take(10));
    }
    return _words[index];
  }

  void removeAt(index) {
    _words.removeAt(index);
    notifyListeners();
  }
}

class Favorites extends ChangeNotifier {
  var _favorites = <WordPair>[];

  int get length => _favorites.length;

  bool isSaved(pair) => _favorites.contains(pair);

  void toggle(pair) {
    if (isSaved(pair)) {
      _favorites.remove(pair);
    } else {
      _favorites.add(pair);
    }
    notifyListeners();
  }

  WordPair operator [](int index) => _favorites[index];

  WordPair removeAt(index) => _favorites.removeAt(index);
}
