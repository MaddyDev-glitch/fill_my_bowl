import 'package:fillmybowl1/abtpage.dart';
import 'package:fillmybowl1/gotsupply.dart';
import 'package:fillmybowl1/location.dart';
import 'package:fillmybowl1/spotted.dart';
import 'package:fillmybowl1/spotted_cold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double currentLatitude;
double currentLongitude;
int path=0;
class LoadingPage extends StatefulWidget {
  int path;
  LoadingPage(this.path);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future getLocation() async {
    print('hello');
    Location location = Location();
    await location.getLocation();
    currentLatitude = location.latitude;
    currentLongitude = location.longitude;
    print(currentLongitude);
    print(currentLatitude);
    // gotLocation = true;
  }

  void pathfinder() async {
    await getLocation();
    setState(() {
      if(widget.path==1)
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Spotted(currentLatitude, currentLongitude);
              },
            ),
          );
        }
      else if(widget.path==2)
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SpottedCold(currentLatitude, currentLongitude);
              },
            ),
          );
        }
      else if(widget.path==3)
      {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return GotSupply(currentLatitude, currentLongitude);
            },
          ),
        );
      }

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pathfinder();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SpinKitCubeGrid(
            color: Colors.amber,
            size: 200,
          )),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text("Loading...",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
              "Please wait till we find where you are \n Getting GPS coordinates",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )),
          )
        ],
      ),
    );
  }
}
