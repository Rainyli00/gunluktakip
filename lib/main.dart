import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ekranlar/ana_ekran.dart'; 
import 'tema.dart';
import 'ekranlar/giris_ekran.dart';
void main() {
  runApp(
    //Tema yönetimi sağlanır
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
      final tema = Provider.of<Tema>(context);//Tema bilgisi alınır
    return MaterialApp(
      debugShowCheckedModeBanner: false,//ekrandaki debug yazısını kaldırır
      title: 'Günlük Takip',
      theme: tema.suankitema ,
      initialRoute: '/',
      routes: {
          '/': (ctx) =>  GirisEkran(), //giriş ekranı
        AnaEkran.routeName: (ctx) => const AnaEkran(),
      },
      
    );
  }
}
