import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'location.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geodesy/geodesy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

var filterConstraint = 2;
String timeagomsg;
String showConstraint = "spot";
bool timeconstraint;
double _currentSliderValue = 2;
Color loc1=Colors.amber;
Color loc2=Colors.grey.shade700;
Color text1 = Colors.black;
Color text2 = Colors.amber;
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
            Text("Filter By Distance",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 10,
            ),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                thumbColor: Colors.red,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.purple.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              ),
              child: Slider(
                activeColor: Colors.amber.shade700,
                  inactiveColor: Colors.amberAccent.shade100,
                  value: _currentSliderValue,
                  min: 1,
                  max: 20,
                  divisions: 50,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                      filterConstraint=value.round();
                      if(filterConstraint==20)
                        {
                          filterConstraint==300;
                        }
                    });
                  }),
            ),


            SizedBox(
              height: 5,
            ),
            Text("Locate Options",
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: loc1,
                          borderRadius: BorderRadius.circular(25)),
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              showConstraint = "spot";
                              List<MessageBubble> messagewidgets = [];
                              loc2=Colors.grey.shade900;
                              loc1=Colors.amber;
                              text1=Colors.black;
                              text2=Colors.amber;
                            });
                          },
                          child: Text(
                            "People",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500,color: text1),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                          color: loc2,
                          borderRadius: BorderRadius.circular(25)),
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              showConstraint = "spotFridge";
                              List<MessageBubble> messagewidgets = [];
                              loc1=Colors.grey.shade900;
                              loc2=Colors.amber;
                              text2=Colors.black;
                              text1=Colors.amber;
                            });
                          },
                          child: Text("Fridges",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500,color: text2)))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Showing the data recieved in past 24 hours",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection(showConstraint).snapshots(),
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
                        Timestamp posttime = imgtemp['time'];
                        int posttimeint = posttime.millisecondsSinceEpoch;
                        int currenttimeint =
                            DateTime.now().millisecondsSinceEpoch;
                        // int posttimeint=DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
                        // int currenttimeint=DateTime.now().millisecondsSinceEpoch;
                        int xyz = currenttimeint - posttimeint;
                        print("$currenttimeint - $posttimeint ==  $xyz");
                        if (xyz > 86400000 + 100)
                          timeconstraint = true;
                        else
                          timeconstraint = false;
                        var tempdist = getDistance(currentLatitude,
                            currentLongitude, templat, templon);
                        timeagomsg = timeago.format(posttime.toDate());
                        final messagewidget = MessageBubble(
                          desc: imgtemp['desc'],
                          lat: imgtemp['lat'],
                          lon: imgtemp['lon'],
                          time: timeagomsg,
                        );
                        if (tempdist <= filterConstraint &&
                            timeconstraint == false) {
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
  final String time;

  MessageBubble({this.desc, this.lat, this.lon, this.time});

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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Posted $time"),
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
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FlatButton(
                        onPressed: () {
                          MapUtils.openMap(lat, lon);
                        },
                        child: Text(
                          "OPEN in MAPS",
                          style: TextStyle(fontSize: 15),
                        ))
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
