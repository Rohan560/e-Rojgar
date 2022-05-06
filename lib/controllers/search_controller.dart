import 'package:flutter/material.dart';

class SearchController with ChangeNotifier {
  String query;

  SearchController({this.query = ''});

  void setQuery(String s) {
    query = s;
    notifyListeners();
  }
}
