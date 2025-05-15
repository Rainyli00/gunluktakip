class Gorev {
  String gorev;
  DateTime zaman;

  Gorev({required this.gorev, required this.zaman});

  factory Gorev.fromString(String gorev) {
    return Gorev(
      gorev: gorev ,
      zaman: DateTime.now(),
    );
  }

factory Gorev.fromMap(Map<String ,dynamic> map) {
    return Gorev(
      gorev: map['gorev'] ,
      zaman: DateTime.fromMillisecondsSinceEpoch(map['tarih']),
    );
  }



Map<String, dynamic> getMap() {
    return {
      'gorev': this.gorev,
      
      'tarih': this.zaman.millisecondsSinceEpoch,
    };
  }

  

}