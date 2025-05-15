import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


void veriKaydet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Gorev g = Gorev.fromString(_gorevController.text);
  //  prefs.setString('gorev', json.encode(g.getMap()));
  
  String gorevler = prefs.getString('gorev') ?? '[]';	

   List<dynamic> list = [];

  if (gorevler != null && gorevler.isNotEmpty) {
    var decoded = json.decode(gorevler);
    if (decoded is List) {
      list = decoded;
    } else {
      // Eğer daha önce yanlışlıkla Map olarak kaydedildiyse sıfırla
      list = [];
    }
  }
    print(list);
    list.add(json.encode(g.getMap()));
    print(list);
    prefs.setString('gorev', json.encode(list));

 _gorevController.clear();
  
    Navigator.of(context).pop();
    _getGorevler(); 

  }

void _getGorevler() async {
  _gorevler = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gorevler = prefs.getString('gorev') ?? '[]';	

   List<dynamic> list = [];

  if (gorevler != null && gorevler.isNotEmpty) {
    var decoded = json.decode(gorevler);
    if (decoded is List) {
      list = decoded;
    } else {
      // Eğer daha önce yanlışlıkla Map olarak kaydedildiyse sıfırla
      list = [];
    }
  }
   for (dynamic d in list) {
    _gorevler.add(Gorev.fromMap(json.decode(d))); 
   }
   

   print(_gorevler);

   _YapilanGorevler = List.generate(_gorevler.length,(index) => false);

setState(() {
  
});


  }

void GorevListeGuncelle() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
List<Gorev> BekleyenGorevler =  [];

for(int i=0; i < _gorevler.length ; i++)  {
  if(!_YapilanGorevler[i]) BekleyenGorevler.add(_gorevler[i]); 
}

var BekleyenGorevlerEncoded = List.generate(
    BekleyenGorevler.length, (i)=> json.encode(BekleyenGorevler[i].getMap()) );

prefs.setString('gorev', json.encode(BekleyenGorevlerEncoded));

_getGorevler();

}


void TumGorevSil() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('gorev', json.encode([]));
  _getGorevler();
}




@override
  void initState() {
    super.initState();
    _gorevController = TextEditingController();

    _getGorevler();
  } 

@override
  void dispose() {
    _gorevController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Günlük Görevler' ,style: GoogleFonts.lato()),
      actions: [
        IconButton(onPressed: GorevListeGuncelle , icon: Icon(Icons.save)),

        IconButton(onPressed: TumGorevSil , icon: Icon(Icons.delete))
        
      ],
      backgroundColor: Colors.greenAccent,centerTitle: true,),
      

      body: (_gorevler==null) ? Center(child: Text('Henüz bir görev eklenmedi!',style: GoogleFonts.lato(),), )
      
    : Column(
  children: [
    Expanded(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: _gorevler.map((e) => Container(
          margin: EdgeInsets.symmetric( vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
          
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                e.gorev,
                style: GoogleFonts.lato(fontSize: 16),
              ),
              Checkbox(
                value: _YapilanGorevler[_gorevler.indexOf(e)], // Burada Checkbox'ın durumunu dinamik olarak değiştirebilirsiniz
                key: GlobalKey(),
                onChanged: (value) {
                 setState(() {
                   _YapilanGorevler[_gorevler.indexOf(e)] = value ?? false;

                 });
                } // Buraya state değişikliği için gerekli logiği ekleyebilirsiniz
              ),
            ],
          ),
        )).toList(),
      ),
    ),
  ],
),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.cyanAccent,
        onPressed: () => showModalBottomSheet(
          context: context,
           builder: (BuildContext context) => Container(
          padding: EdgeInsets.all(20),
          height: 250,
          width: double.infinity,
         
          color: Colors.tealAccent,
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
        ),
      ),
    ); 
    
  }
}