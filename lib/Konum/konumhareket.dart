import 'dart:async';

import 'package:application/Konum/konum.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class KonumHareket extends StatefulWidget {
  @override
  _KonumHareketState createState() => _KonumHareketState();
}

class _KonumHareketState extends State<KonumHareket> {
  //konumu firebase e kaydetme
  //var locations = FirebaseDatabase.instance.reference().child("konum_tablo");

  @override
  void initState() {
    _handleRefresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Konum Hareket"),
      ),
      backgroundColor: Colors.teal[100],
      body: new RefreshIndicator(
        child: _getItems(),
        onRefresh: _handleRefresh,
      ),
    );
  }

  _getItems() {
    return Column(
      children: <Widget>[
        new Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 100 / 100,
                height: MediaQuery.of(context).size.height * 93 / 100,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                            child: Card(
                              color: Colors.teal[100],
                              child: Center(
                                child: Text(
                                  "Mesafe : $mesafee m",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                            child: Card(
                              color: Colors.teal[100],
                              child: Center(
                                child: Text(
                                  "Hız : $yayahizi km",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                            child: Card(
                              color: Colors.teal[100],
                              child: Center(
                                child: Text(
                                  "Kat edilen Mesafe : $katedilenmesafe m",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                            child: Card(
                              color: Colors.teal[100],
                              child: Center(
                                child: Text(
                                  "Yaya : $yayazamani sn",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                            child: Card(
                              color: Colors.teal[100],
                              child: Center(
                                child: Text(
                                  "Konum: $enlem2 - $boylam2",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Null> _handleRefresh() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      setState(() {
        //konumu firebase e kaydetme
        //var bilgi = HashMap<String, dynamic>();
        //bilgi["enlem"] = enlem2;
        //bilgi["boylam"] = boylam2;
        //locations.push().set(bilgi);

        _getItems();
        _hizuyari();
        _mesafeuyari();
        _metreuyari();
      });

      if (mesafee <= katedilenmesafe) {
        timer.cancel();
      } else if (yayahizii == 0.00) {
        timer.cancel();
      }
    });
  }

  Future<Null> _hizuyari() {
    if (yayahizi <= 2.6) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("UYARI"),
          content: const Text("Hızı 2.6 km altında"),
          actions: [
            new FlatButton(
              child: const Text("Kapat"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else if (yayahizi >= 3.0) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("UYARI"),
          content: const Text("Hız 3 km üstünde"),
          actions: [
            new FlatButton(
              child: const Text("Kapat"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {}
  }

  Future<Null> _mesafeuyari() {
    if (katedilenmesafe == mesafee - 100 ||
        katedilenmesafe == mesafee - 101 ||
        katedilenmesafe == mesafee - 102 ||
        katedilenmesafe == mesafee - 103 ||
        katedilenmesafe == mesafee - 104 ||
        katedilenmesafe == mesafee - 105 ||
        katedilenmesafe == mesafee - 106 ||
        katedilenmesafe == mesafee - 107 ||
        katedilenmesafe == mesafee - 108) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("UYARI"),
          content: const Text("Hedefe 100 metre kaldı"),
          actions: [
            new FlatButton(
              child: const Text("Kapat"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Future<Null> _metreuyari() {
    if (katedilenmesafe % 50 == 0 ||
        katedilenmesafe % 50 == 1 ||
        katedilenmesafe % 50 == 2 ||
        katedilenmesafe % 50 == 3 ||
        katedilenmesafe % 50 == 4 ||
        katedilenmesafe % 50 == 5 ||
        katedilenmesafe % 50 == 6 ||
        katedilenmesafe % 50 == 7 ||
        katedilenmesafe % 50 == 8 ||
        katedilenmesafe % 50 == 9) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("UYARI"),
          content: Text("50 metrede bir sonuç " +
              "\n" +
              "Mesafe : $mesafee m" +
              "\n" +
              "Kat edilen mesafe: $katedilenmesafe m" +
              "\n" +
              "Zaman :$yayazamani sn"),
          actions: [
            new FlatButton(
              child: const Text("Kapat"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }
}
