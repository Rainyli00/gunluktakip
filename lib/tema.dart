import 'package:flutter/material.dart';
//Tema yönetimi sınıfı
//Açık ve karanlık mod arasında geçiş yapar
class Tema extends ChangeNotifier {

  bool _darkmod = false;
  //Güncel temayı döndürür
  ThemeData get suankitema {
    return _darkmod ? ThemeData.dark() : ThemeData.light();
  }
  void temaDegistir() {
    _darkmod = !_darkmod;
    notifyListeners();//widget'lara tema değişikliği olduğunu bildir
  }
}

