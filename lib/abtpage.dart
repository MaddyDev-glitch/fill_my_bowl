import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class UrlOpen{

  UrlOpen._();

  
  static Future<void> openLink(String URL) async {
    String gitUrlp = '$URL';
    if (await canLaunch(gitUrlp)) {
      await launch(gitUrlp);
    } else {
      throw 'Could not open Git';
    }
  }
}

class AbtPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20,),

                Text("Developers",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w200,color: Colors.amber),),
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundImage: AssetImage('images/maddyimg.PNG'),
                  radius: 50.0,
                ),
                Text(
                  'T Srimadhaven',
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    color: Colors.amber,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 100.0,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.add_call,
                      color: Colors.amber,
                    ),
                    title: Text(
                      '+91 8939266030',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.amber,
                    ),
                    title: Text(
                      'sri.madhaven@gmail.com',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.code,
                      color: Colors.amber,
                    ),
                    title: Text(
                      'github.com/MaddyDev-glitch',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      onTap: () => UrlOpen.openLink('https://github.com/MaddyDev-glitch')
                  ),
                  ),


              SizedBox(
                  height: 20.0,
                  width: 250.0,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),

                CircleAvatar(
                  backgroundImage: AssetImage('images/pri_img.jpeg'),
                  radius: 50.0,
                ),
                Text(
                  'Mohanapriya Singaravelu',
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    color: Colors.amber,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 100.0,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.add_call,
                      color: Colors.amber,
                    ),
                    title: Text(
                      '+91 7200815111',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.amber,
                    ),
                    title: Text(
                      'mohanapriya.singaravelu@gmail.com',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black54,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.code,
                      color: Colors.amber,
                    ),
                    title: Text(
                      'github.com/priya-velu5',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      onTap: () => UrlOpen.openLink('https://github.com/priya-velu5')
                  ),
                ),
            ],
        ),
          ),
          ),
        ),
      );
  }
}
