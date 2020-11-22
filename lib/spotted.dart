import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';

double coverHeight = 350;
double currentLatitude;
double currentLongitude;
bool gotLocation=false;
final _firestoresend = FirebaseFirestore.instance;

class Spotted extends StatefulWidget {
  @override
  _SpottedState createState() => _SpottedState();
}

class _SpottedState extends State<Spotted> {
  @override
  void initState() {

    getLocation();
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        coverHeight = visible ? 170 : 350;
        print(coverHeight);
      });
    });
    super.initState();

    // myContent = new TextEditingController(text: null);
  }

  void _showConfirm() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: new Text('Feed My Bowl',style: TextStyle(color: Colors.amber),),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Yaay!',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text('Thank you for helping the community by spotting a needy person :)',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Okay',style: TextStyle(color: Colors.amber,fontSize: 18),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showError() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          backgroundColor: Colors.grey.shade900,

          title: new Text('Feed My Bowl',style: TextStyle(color: Colors.amber),),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Ah Snap :/',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  'Looks like something went wrong',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade600),
                ),
                new SizedBox(
                  height: 20,
                ),
                new Text('Check if you have filled in the description before submitting\n Check if your location services is enabled',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Okay',style: TextStyle(color: Colors.amber,fontSize: 18),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future getLocation() async {
    print('hello');
    Location location = Location();
    location.getLocation();
    currentLatitude = location.latitude;
    currentLongitude = location.longitude;
    print(currentLongitude);
    print(currentLatitude);
    gotLocation=true;
  }

  final mydesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  AnimatedContainer(
                    curve: Curves.easeInOutQuad,
                    duration: Duration(
                      milliseconds: 400,
                    ),
                    height: coverHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/vector1.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 12,
                          blurRadius: 8,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 480),
                        curve: Curves.easeInOutQuad,
                        padding: EdgeInsets.only(top: coverHeight),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "I Spotted a needy person",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color(0xffFAC000),
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: new TextField(
                controller: mydesc,
                style: TextStyle(color: Colors.white, fontSize: 20),
                maxLines: 5,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.white),
                    hintText: "Type in your text",
                    fillColor: Color(0x553E456D)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 12, bottom: 12),
                  child: Text(
                    "Notify",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.amberAccent)),
                onPressed: () {

                  setState(() {
                    if(gotLocation==true && mydesc.text!="")
                      {
                        _firestoresend
                            .collection("spot").add({"lat": currentLatitude, "lon": currentLongitude,"desc":mydesc.text});
                        mydesc.clear();
                        _showConfirm();
                      }
                    else
                      {
                        _showError();
                      }
                  });
                })
          ],
        ),
      ),
    ));
  }
}
