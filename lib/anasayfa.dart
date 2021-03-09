import 'package:application/Fotograf/fotograf.dart';
import 'package:application/Konum/konum.dart';

import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();

    showOverlay();
  }

  bool _isLoading = false;

  void showOverlay() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Anasayfa"),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.7,
        progressIndicator: SizedBox(
            width: 140,
            child: LoadingIndicator(
              color: Colors.blueGrey[400],
              indicatorType: Indicator.pacman,
            )),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ButtonBar(
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blueGrey[400],
                      onPressed: () {
                        showOverlay();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Konum()));
                      },
                      child: Text("Konum"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blueGrey[400],
                      onPressed: () {
                        showOverlay();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Fotograf()));
                      },
                      child: Text("Fotoğraf"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
