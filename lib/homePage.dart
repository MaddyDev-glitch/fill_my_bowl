import 'package:fillmybowl1/abtpage.dart';
import 'package:fillmybowl1/gotsupply.dart';
import 'package:fillmybowl1/location.dart';
import 'package:fillmybowl1/spotted.dart';
import 'package:fillmybowl1/spotted_cold.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/widgets.dart';


double currentLatitude;
double currentLongitude;
const DarkBlue = const Color(0xff3E456D);
const greyBlue = const Color(0xff90A6BE);
const amberish = const Color(0xffFAC000);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var heightscreen = MediaQuery.of(context).size.height / 2;
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

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff271f46),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()async{
                        await getLocation();
                        setState(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SpottedCold(currentLatitude, currentLongitude);
                              },
                            ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Spotted Fridge",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        setState(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AbtPage();
                              },
                            ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "</> About Us",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () async{
                await getLocation();
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Spotted(currentLatitude, currentLongitude);
                      },
                    ),
                  );
                });
              },
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2),
                decoration: BoxDecoration(color: Color(0xff271f46)),
                child: Image.asset(
                  'images/two.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await getLocation();
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return GotSupply(currentLatitude, currentLongitude);
                      },
                    ),
                  );
                });
              },
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2),
                decoration: BoxDecoration(color: Colors.grey.shade900),
                child: Image.asset(
                  'images/one.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// 0xff3E456D - dark blueish grey
//0xff90A6BE - blueish grey
//0xffFAC000 - amberish
// ff - opacity digits
// <a href='https://www.freepik.com/vectors/food'>Food vector created by pch.vector - www.freepik.com</a> - homeless vector

// donate vector - <a href='https://www.freepik.com/vectors/food'>Food vector created by pch.vector - www.freepik.com</a>
