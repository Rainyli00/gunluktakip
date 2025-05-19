class Gorev {
  String gorev;
  DateTime zaman;
//Görev ve zaman bilgisi alınır
  Gorev({required this.gorev, required this.zaman});

//Görev oluşturulur
  factory Gorev.fromString(String gorev) {
    return Gorev(
      gorev: gorev ,
      zaman: DateTime.now(),
    );
  }

//Map tipinden görev nesnesi oluşturur
factory Gorev.fromMap(Map<String ,dynamic> map) {
    return Gorev(
      gorev: map['gorev'] ,
      zaman: DateTime.fromMillisecondsSinceEpoch(map['tarih']),
    );
  }

 // Görev nesnesini Map'e dönüştürür
Map<String, dynamic> getMap() {
    return {
      'gorev': this.gorev,
      'tarih': this.zaman.millisecondsSinceEpoch,//DateTime direkt olarak Json'a saklanamaz ondan dolayı int tipine çevrilir ve bu şekilde kullanılır
    };
  }

}