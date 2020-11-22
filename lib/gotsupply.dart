import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'location.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geodesy/geodesy.dart';
import 'package:url_launcher/url_launcher.dart';

var filterConstraint = 2;

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

Geodesy geodesy = Geodesy();
double currentLatitude;
double currentLongitude;
bool gotLocation = false;
List<Widget> list = new List();
final _firestore = FirebaseFirestore.instance;

int getDistance(double lat1, double lon1, double lat2, double lon2) {
  LatLng userpos = LatLng(lat1, lon1);
  LatLng tagpos = LatLng(lat2, lon2);
  num distance = geodesy.distanceBetweenTwoGeoPoints(userpos, tagpos);
  num distinKM = distance / 1000;
  distinKM = distinKM.toInt();
  print("OVER HERE");
  print(distinKM);
  return distinKM;
}

class GotSupply extends StatefulWidget {
  double lat;
  double lon;
  GotSupply(this.lat, this.lon);

  @override
  _GotSupplyState createState() => _GotSupplyState();
}

class _GotSupplyState extends State<GotSupply> {
  @override
  void initState() {
    // getLocation();
    currentLatitude = widget.lat;
    currentLongitude = widget.lon;
    super.initState();
    filterConstraint = 2;
    // myContent = new TextEditingController(text: null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "I Got Supplies",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("Filter Options",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(25)),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            filterConstraint = 2;
                          });
                        },
                        child: Text("2 Km",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
                Container(
                    decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(25)),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            filterConstraint = 5;
                          });
                        },
                        child: Text("5 Km",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)))),
                Container(
                    decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(25)),
                    child: FlatButton(onPressed: () {
                      setState(() {
                        filterConstraint = 10;

                      });
                    }, child: Text("10 Km",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)))),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('spot').snapshots(),
                  builder: (context, snapshot) {
                    List<MessageBubble> messagewidgets = [];
                    if (snapshot.hasData) {
                      messagewidgets.clear();
                      final messages = snapshot.data.documents;
                      for (var message in messages) {
                        final imgtemp = message.data();
                        print("----------=========== ${imgtemp}");
                        var templat = imgtemp['lat'];
                        var templon = imgtemp['lon'];
                        var tempdist = getDistance(currentLatitude,
                            currentLongitude, templat, templon);
                        final messagewidget = MessageBubble(
                          desc: imgtemp['desc'],
                          lat: imgtemp['lat'],
                          lon: imgtemp['lon'],
                        );
                        if (tempdist <= filterConstraint) {
                          messagewidgets.add(messagewidget);
                        }
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: messagewidgets,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

class MessageBubble extends StatelessWidget {
  final String desc;
  final double lat;
  final double lon;

  MessageBubble({this.desc, this.lat, this.lon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.amber),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  desc,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Row(
                  children: [
                    Text(
                      "Distance:",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "${getDistance(currentLatitude, currentLongitude, lat, lon).toString()} Km",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FlatButton(
                        onPressed: () {
                          MapUtils.openMap(lat, lon);
                        },
                        child: Text("OPEN in MAPS",style: TextStyle(fontSize: 15),))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
