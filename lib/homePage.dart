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
import 'package:fillmybowl1/LoginPage.dart' as login;

String userName = login.user.displayName;
double currentLatitude;
double currentLongitude;
User localvaruser;
const DarkBlue = const Color(0xff3E456D);
const greyBlue = const Color(0xff90A6BE);
const amberish = const Color(0xffFAC000);
// Checkusername() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String name = prefs.getString('prefusername');
//   print("super:$name");
//   userName = name;
// }

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
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text("Home Page",style: TextStyle(fontSize: 40,color: amberish,fontWeight: FontWeight.w200),),
              ),
              // toolbarHeight: 30,
              backgroundColor: Colors.black54,
              shadowColor: Color(0xff271f46),
            ),
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: FlatButton(
                        //     padding: EdgeInsets.zero,
                        //     onPressed: ()async{
                        //       await getLocation();
                        //       setState(() {
                        //         Navigator.of(context).push(
                        //           MaterialPageRoute(
                        //             builder: (context) {
                        //               return SpottedCold(currentLatitude, currentLongitude);
                        //             },
                        //           ),
                        //         );
                        //       });
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.blueAccent),
                        //           borderRadius: BorderRadius.circular(20)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(
                        //           "Spotted Fridge",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w300),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: FlatButton(
                        //     padding: EdgeInsets.zero,
                        //     onPressed: () {
                        //       setState(() {
                        //         Navigator.of(context).push(
                        //           MaterialPageRoute(
                        //             builder: (context) {
                        //               return AbtPage();
                        //             },
                        //           ),
                        //         );
                        //       });
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.blueAccent),
                        //           borderRadius: BorderRadius.circular(20)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(
                        //           "</> About Us",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w300),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
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
                              return Spotted(currentLatitude, currentLongitude);
                            },
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'images/spotted.png',
                          // width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),

                  //Locate cold
                  FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await getLocation();
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SpottedCold(
                                  currentLatitude, currentLongitude);
                            },
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'images/threetwo.png',
                          // width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),

                  //DONATE
                  FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await getLocation();
                        setState(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return GotSupply(
                                    currentLatitude, currentLongitude);
                              },
                            ),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            'images/donate.png',
                            // width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.all(12.0),
                      //   child: Container(
                      //     constraints: BoxConstraints(
                      //         maxHeight: MediaQuery.of(context).size.height),
                      //     width: MediaQuery.of(context).size.width,
                      //     // height: (MediaQuery.of(context).size.height)/3 ,
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey.shade900,
                      //       borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      //     ),
                      //     child: Image.asset(
                      //       'images/donate.png',
                      //       // width: MediaQuery.of(context).size.width,
                      //     ),
                      //   ),
                      // ),
                      ),
                ],
              ),
            ),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Color(
                    0xff271f33), //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text(
                        'Welcome',
                        style: TextStyle(fontSize: 50, color: amberish),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff271f46),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'About Us',
                        style: TextStyle(color: amberish, fontSize: 30),
                      ),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AbtPage();
                            },
                          ),
                        );
                      },
                    ),
                    // SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 5, bottom: 5),
                      child: Divider(
                        color: Colors.amber,
                      ),
                    ),
                    // ListTile(
                    //   title: Text(
                    //     'Why we created this app?',
                    //     style: TextStyle(color: amberish, fontSize: 30),
                    //   ),
                    //   onTap: () {
                    //     // Update the state of the app
                    //     // ...
                    //     // Then close the drawer
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    // // SizedBox(height: 15,),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 40, right: 40, top: 5, bottom: 5),
                    //   child: Divider(
                    //     color: Colors.amber,
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text(
                    //     'How it works?',
                    //     style: TextStyle(color: amberish, fontSize: 30),
                    //   ),
                    //   onTap: () {
                    //     // Update the state of the app
                    //     // ...
                    //     // Then close the drawer
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 40, right: 40, top: 5, bottom: 5),
                    //   child: Divider(
                    //     color: Colors.amber,
                    //   ),
                    // ),
                  ],
                ),
              ),
            )));
  }
}

// 0xff3E456D - dark blueish grey
//0xff90A6BE - blueish grey
//0xffFAC000 - amberish
// ff - opacity digits
// <a href='https://www.freepik.com/vectors/food'>Food vector created by pch.vector - www.freepik.com</a> - homeless vector

// donate vector - <a href='https://www.freepik.com/vectors/food'>Food vector created by pch.vector - www.freepik.com</a>
