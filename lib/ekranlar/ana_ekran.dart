import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gunluktakip/tema.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../model/gorev.dart';



class AnaEkran extends StatefulWidget {

  static const routeName = '/ana-ekran';
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
var _gorevController;
late List<Gorev> _gorevler;
late List<bool> _YapilanGorevler;

// Yeni görev kaydeder
void veriKaydet() async {
    //Sharedpreferences başlatılır (yerel depolama için)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Gorev g = Gorev.fromString(_gorevController.text); // textfield da girilien metne göre görev nesnesi oluşturur

  
  String gorevler = prefs.getString('gorev') ?? '[]';	

   List<dynamic> list = [];

   //kayıtlı görevleri decode eder

  if (gorevler != null && gorevler.isNotEmpty) {
    var decoded = json.decode(gorevler);
    if (decoded is List) {
      list = decoded;
    } else {
     
      list = [];
    }
  }
    print(list);
    // yeni görevi listeye ekler
    list.add(json.encode(g.getMap()));
    print(list);
    prefs.setString('gorev', json.encode(list)); //güncellenen listeyi kaydeder

 _gorevController.clear();
  
    Navigator.of(context).pop();
    _getGorevler(); 

  }

// görevleri getirir
void _getGorevler() async {
  _gorevler = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //kayıtlı görevleri alır veya boş bir liste başlatır
    String gorevler = prefs.getString('gorev') ?? '[]';	

   List<dynamic> list = [];

 //kayıtlı görevleri decode eder
  if (gorevler != null && gorevler.isNotEmpty) {
    var decoded = json.decode(gorevler);
    if (decoded is List) {
      list = decoded;
    } else {
      
      list = [];
    }
  }

  //decode edilen görevleri nesneye dönüştürür
   for (dynamic d in list) {
    _gorevler.add(Gorev.fromMap(json.decode(d))); 
   }
   

   print(_gorevler);

// Görevler için yapıldı, yapılmadı durumunu tutan liste oluştur
   _YapilanGorevler = List.generate(_gorevler.length,(index) => false);

// state i günceller
setState(() {
  
});


  }

// Yapılan görevleri listeden çıkarır  
void GorevListeGuncelle() async {
SharedPreferences prefs = await SharedPreferences.getInstance();

// Tamamlanmamış görevler listesi oluşturulur
List<Gorev> BekleyenGorevler =  [];

// Tamamlanmamış görevleri ayıklar ve BekleyenGorevler listesine ekler
for(int i=0; i < _gorevler.length ; i++)  {
  if(!_YapilanGorevler[i]) BekleyenGorevler.add(_gorevler[i]); 
}

// Görev listesini json formatında encode eder
var BekleyenGorevlerEncoded = List.generate(
    BekleyenGorevler.length, (i)=> json.encode(BekleyenGorevler[i].getMap()) );

// Güncellenen listeyi kaydeder
prefs.setString('gorev', json.encode(BekleyenGorevlerEncoded));

// Görev listesini yeniler
_getGorevler();

}


void TumGorevSil() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // görev listesini boş liste olarak kaydeder yani sıfılar
  prefs.setString('gorev', json.encode([]));

  // Görev listesini yeniler
  _getGorevler();
}


// Görev ekleme panelini açar.
void BottomSheetAc() {
  showModalBottomSheet(
          context: context,
           builder: (BuildContext context) => Container(
          padding: EdgeInsets.all(20),
          height: 250,
          width: double.infinity,
         
          color: Colors.teal,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                      'Görev Ekle'
                      
                      , style: GoogleFonts.lato(
                        fontSize: 22,
                       
                        color: Colors.black,
                      ),
                      
                    ),
                    // kapatma butonu
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,),

              // Görev ekleme alanı 
            TextField(
              controller: _gorevController,
              decoration: InputDecoration(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black ),
               

              
              ),
               fillColor: Colors.white,
              filled: true,
              hintText: 'Görev Giriniz',
              hintStyle: GoogleFonts.lato(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width:MediaQuery.of(context).size.width,
              

              child: Row( 
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 25,

                    // girilen yazıyı sıfırlama butonu
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent
                    ),
                    child: Text('Sıfırla',style: GoogleFonts.lato(),),
                    onPressed:() => _gorevController.clear(),
                    ),
                  ),
              
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
                    // görev ekleme butonu
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent
                    ),
                    child: Text('Ekle',style: GoogleFonts.lato(),),
                    onPressed:() => veriKaydet(),
                    ),
                  ),
              
                  
                ],
              ),
            )

              
              ],
            ),
          ),
        );


}


@override
  void initState() {
    super.initState();
    // görev giriş alanı için controller oluşturur
    _gorevController = TextEditingController();

// görevleri getirir
    _getGorevler();
  } 

@override
  void dispose() {
    // controllerı temizler
    _gorevController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Günlük Görevler' ,style: GoogleFonts.lato()),
      actions: [
        // yapılan görevleri silen buton
        IconButton(onPressed: GorevListeGuncelle , icon: Icon(Icons.save)),

       // tüm görevleri silen buton
        IconButton(onPressed: TumGorevSil , icon: Icon(Icons.delete))
        
      ],
      backgroundColor: Colors.teal,centerTitle: true,),
      
// görev listesi kısmı (görevler listesi boşsa texti yazar doluysa ekrana görevleri getirir )
      body: (_gorevler.isEmpty) ? Center(child: Text('Henüz bir görev eklenmedi!',style: GoogleFonts.lato(),), )
      
    : Column(
  children: [
    Expanded(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: _gorevler.map((e) => Container(
          margin: EdgeInsets.symmetric( vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.surface,
          
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
            width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                e.gorev,
                style: GoogleFonts.lato(fontSize: 16,
                // görev yapıldıysa üstünü çizer yoksa aynı kalır
                decoration: _YapilanGorevler[_gorevler.indexOf(e)] ? TextDecoration.lineThrough : TextDecoration.none,
                color: Theme.of(context).colorScheme.onSurface, 
                ),
              ),

              
              Checkbox(
                
                value: _YapilanGorevler[_gorevler.indexOf(e)],  
                key: GlobalKey(),
                onChanged: (value) {
                 setState(() {
                  // check box değiştiğinde görev durumu güncellenir
                   _YapilanGorevler[_gorevler.indexOf(e)] = value ?? false;

                 });
                } 
              ),
            ],
          ),
        )).toList(),
      ),
    ),
  ],
),

// çoklu buton menüsü
      floatingActionButton: SpeedDial(
        child: Icon(Icons.menu,color: Colors.white,),
        backgroundColor: Colors.cyanAccent,
        children: [
          // Görev ekle butonu
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Görev Ekle',
            backgroundColor: Colors.greenAccent,
            onTap: () => BottomSheetAc(), //tıklanınca bottomsheeti açar
          ),
          // Tema Değiştir butonu
          SpeedDialChild(
            child: Icon(Icons.brightness_6),
            
            label: 'Tema Değiştir',
            backgroundColor: Colors.redAccent,
            onTap: () => Provider.of<Tema>(context, listen: false).temaDegistir(), // tıklanınca temayı değiştirir

          ),
        ],
      ),




    ); 
    
  }
}