import 'dart:collection';

import 'package:application/Giris/giris.dart';
import 'package:application/Konum/konum.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    var _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Giris(),
    );
  }
}
