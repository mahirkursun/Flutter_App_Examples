class Konumlar {
  int markId;
  double enlem;
  double boylam;
  double hiz;

  Konumlar(this.markId, this.enlem, this.boylam, this.hiz);

  factory Konumlar.fromJson(Map<dynamic, dynamic> json) {
    return Konumlar(json["markId"] as int, json["enlem"] as double,
        json["boylam"] as double, json["hiz"] as double);
  }
}
