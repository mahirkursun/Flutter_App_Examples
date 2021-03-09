import 'package:application/Fotograf/imagepreview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

class Fotograf extends StatefulWidget {
  @override
  _FotografState createState() => _FotografState();
}

class _FotografState extends State<Fotograf> {
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

  List<Asset> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Fotoğraf"),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    iconSize: 40,
                    onPressed: () {
                      pickImages();
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera),
                  iconSize: 40,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
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
        child: new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              images == null
                  ? Container(
                      height: 200.0,
                      width: 200.0,
                      child: new Icon(
                        Icons.image,
                        size: 150.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 100 / 100,
                      child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            var asset = images[index];
                            var resim = images;
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("UYARI"),
                                          content: const Text(
                                              "Silmek istiyor musunuz?"),
                                          actions: [
                                            new FlatButton(
                                              child: const Text("Evet"),
                                              onPressed: () {
                                                setState(() {
                                                  images.remove(images[index]);
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: const Text("Hayır"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImagePreview(
                                              images: asset,
                                              resim: resim,
                                            ),
                                          ));
                                    },
                                    child: AssetThumb(
                                      asset: images[index],
                                      height: 400,
                                      width: 250,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80.0),
                                        child: IconButton(
                                          icon:
                                              Icon(Icons.rotate_90_degrees_ccw),
                                          color: Colors.white,
                                          iconSize: 35,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    List resultList;

    resultList = await MultiImagePicker.pickImages(
      maxImages: 20,
    );

    setState(() {
      if (images == null) {
        images = resultList;
      } else {
        images += resultList;
      }
    });
  }

  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var androidAyari = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosAyari = IOSInitializationSettings();
    var kurulumAyari = InitializationSettings(androidAyari, iosAyari);

    await flp.initialize(kurulumAyari);
  }

  Future<void> bildirimGoster() async {
    var androidBildirimDetay = AndroidNotificationDetails(
      "Kanal id",
      "Fotoğraf",
      "Fotoğraf Sayfasındasınız.",
      priority: Priority.High,
      importance: Importance.Max,
    );

    var iosBildirimDetay = IOSNotificationDetails();
    var bildirimDetay =
        NotificationDetails(androidBildirimDetay, iosBildirimDetay);

    await flp.show(0, "Başlık", "İçerik", bildirimDetay,
        payload: "payLoad içerik");
  }
}
