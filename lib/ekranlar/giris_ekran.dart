
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:gunluktakip/ekranlar/ana_ekran.dart';

//Giriş ekranı

class GirisEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 730),
              // Başla Butonu
              ElevatedButton(
                onPressed: () {
                 Navigator.pushReplacementNamed(context, AnaEkran.routeName);//Başla butonuna basıldığında ana ekrana yönlendirme yapılır
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), 
                  ),
                ),
                child: Text('Başla', style: GoogleFonts.roboto(color: Colors.black)),
              ),
            ],
          ),
        ),
     ),
);
}
}