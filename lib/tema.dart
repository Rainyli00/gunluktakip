import 'package:flutter/material.dart';

class Tema extends ChangeNotifier {

  bool _darkmod = false;
  
  ThemeData get suankitema {
    return _darkmod ? ThemeData.dark() : ThemeData.light();
  }
  void temaDegistir() {
    _darkmod = !_darkmod;
    notifyListeners();
  }



}

