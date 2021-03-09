import 'package:application/Giris/fadeanimation.dart';

import 'package:application/anasayfa.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Giris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(
          "Giriş",
        ),
      ),
      backgroundColor: Colors.teal[100],
      body: Container(
        child: FadeAnimation(
          2.0,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 30 / 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/favv.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          width: MediaQuery.of(context).size.width * 85 / 100,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]),
                                )),
                                child: TextField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.grey,
                                      border: InputBorder.none,
                                      hintText: "Kullanıcı Adı",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Şifre",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 45,
                    ),
                    FadeAnimation(
                        2,
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 85 / 100,
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.blueGrey[400],
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Anasayfa()));
                            },
                            child: Center(
                              child: Text(
                                "Giriş",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
