import 'dart:async';

import 'package:application/Konum/konumhareket.dart';
import 'package:application/Konum/konumlar.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Konum extends StatefulWidget {
  Konum({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KonumState createState() => _KonumState();
}

final LatLng kaynak = LatLng(isaretenlem, isaretboylam);
final LatLng hedef = LatLng(37.033863, 37.319114);

int yayazamani;
int mesafee;
int katedilenmesafe;
int yayahizii;
double yol = 0;
double yayazaman = 0;
double yayazaman1 = 5;
double hiz = 0;
double enlem = 0.0;
double boylam = 0.0;
double enlem2 = 0.0;
double boylam2 = 0.0;
double isaretenlem = 0.0;
double isaretboylam = 0.0;
int markId = 0;
double yayahizi = 0.0;

var locations = FirebaseDatabase.instance.reference().child("konum_tablo");

Future<void> konumBilgisiAl() async {
  //firebase veri çekme
  //locations.once().then((DataSnapshot snapshot) {
  //print('Data : ${snapshot.value}');
  //});

  Geolocator.getPositionStream().listen((Position position) {
    enlem2 = position.latitude;
    boylam2 = position.longitude;
    yayahizi = position.speed;
  });

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  isaretenlem = position.latitude;
  isaretboylam = position.longitude;

  //mesafe zaman hesaplama
  double mesafe = Geolocator.distanceBetween(
    kaynak.latitude,
    kaynak.longitude,
    hedef.latitude,
    hedef.longitude,
  );
  //sayi yuvarlama
  mesafe = mesafe / 10;
  mesafee = mesafe.toInt();
  mesafee = mesafee * 10;

  Timer.periodic(Duration(seconds: 5), (timer) async {
    yayazaman += 5;

    yol = yol + (yayazaman1 * yayahizi);

    katedilenmesafe = yol.toInt();
    yayazamani = yayazaman.toInt();
    yayahizii = yayahizi.toInt();
    //5 sn de bir konum

    if (mesafee <= katedilenmesafe) {
      timer.cancel();
    } else if (yayahizii == 0.00) {
      timer.cancel();
    }
  });
  //50 metrede bir konum
}

class _KonumState extends State<Konum> {
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

  String GoogleApiKEY = "API_KEY";
  CameraPosition baslangicKonum = CameraPosition(
    target: LatLng(37.055662761196686, 37.34196807564323),
    zoom: 13,
  );
  Completer<GoogleMapController> haritaKontrol = Completer();
  Set<Polyline> _polylines = {};

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  final Set<Marker> isaret = Set();

  final Set<Polyline> _polyline = {};
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      konumBilgisiAl();
    });

    showOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Row(
          children: [
            Text("Konum"),
            Spacer(
              flex: 1,
            ),
            IconButton(
              icon: Icon(
                Icons.map_sharp,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KonumHareket()));
              },
            )
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
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          polylines: _polylines,
          onCameraIdle: () {
            print('camera stop');
          },
          initialCameraPosition: baslangicKonum,
          onMapCreated: onMapCreated,
          markers: isaret,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_road, size: 40),
              title: Text(
                "Mesafe :$mesafee m",
                style: TextStyle(fontSize: 16),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk, size: 40),
              title: Text(
                "Yaya :$yayazamani sn",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      haritaKontrol.complete(controller);
      setMapPins();
      setPolylines();
    });
    _initMarkers();
  }

  void setMapPins() {
    isaret.add(Marker(
        markerId: MarkerId("1"),
        position: kaynak,
        infoWindow: InfoWindow(
          title: "konum",
        ),
        icon: BitmapDescriptor.defaultMarker,
        visible: true));
    isaret.add(Marker(
        markerId: MarkerId("2"),
        position: hedef,
        infoWindow: InfoWindow(
          title: "kaynak: Gaün",
        ),
        icon: BitmapDescriptor.defaultMarker,
        visible: true));
  }

  void _initMarkers() async {
    var sorgu = locations.orderByChild("markId");

    sorgu.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value;

      if (gelenDegerler != null) {
        gelenDegerler.forEach((key, nesne) {
          var gelenKonum = Konumlar.fromJson(nesne);
          markId = gelenKonum.markId;
          isaretenlem = gelenKonum.enlem;
          isaretboylam = gelenKonum.boylam;
          final List<LatLng> isaretler = [LatLng(isaretenlem, isaretboylam)];
          for (LatLng markerLocation in isaretler) {
            final String markerIdVal = 'markId${markId}';
            markId++;
            isaret.add(Marker(
                markerId: MarkerId(markerIdVal),
                position: markerLocation,
                infoWindow: InfoWindow(
                  title: "",
                ),
                icon: BitmapDescriptor.defaultMarker,
                visible: true));
          }

          print("Enlem :${isaretler}");
        });
      }
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        GoogleApiKEY,
        kaynak.latitude,
        kaynak.longitude,
        hedef.latitude,
        hedef.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }
}
