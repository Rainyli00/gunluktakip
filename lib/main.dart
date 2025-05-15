import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ekranlar/ana_ekran.dart'; 
import 'tema.dart';

void main() {
  runApp(
ChangeNotifierProvider(
  create: (_) => Tema(),  
  child: const MainApp(),
)  

  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

   

  @override
  Widget build(BuildContext context) {
      final tema = Provider.of<Tema>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema.suankitema,
      home : AnaEkran(),
    );
  }
}
