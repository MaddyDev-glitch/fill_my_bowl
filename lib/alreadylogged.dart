import 'package:fillmybowl1/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

User user;
Prefsetsignin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue',1);
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isLoggedIn = false;
var det = "";

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: ${user}');
    det = await user.displayName;
    print(det);
    Prefsetsignin();
    return '${user.displayName}';
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class AlreadyLoginPage extends StatefulWidget {
  @override
  _AlreadyLoginPageState createState() => _AlreadyLoginPageState();
}

class _AlreadyLoginPageState extends State<AlreadyLoginPage> {
  //====================================================================
  // void initiateFacebookLogin() async {
  //   var facebookLogin = FacebookLogin();
  //   var facebookLoginResult =
  //   // await facebookLogin.logInWithReadPermissions(['name']);
  //   await facebookLogin.logIn(["email"]);
  //   print(facebookLoginResult.errorMessage);
  //   print(facebookLoginResult.accessToken);
  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       print("Error");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print("CancelledByUser");
  //       onLoginStatusChanged(false);
  //       break;
  //     case FacebookLoginStatus.loggedIn:
  //       {
  //         print("LoggedIn");
  //         onLoginStatusChanged(true);
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) {
  //               return HomePage();
  //             },
  //           ),
  //         );
  //         break;
  //       }
  //   }
  // }

  // void onLoginStatusChanged(bool isLoggedIn) {
  //   setState(() {
  //     isLoggedIn = isLoggedIn;
  //   });
  // }

  //=====================================================================
  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInWithGoogle().then((result) {
      if (result != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("images/logonew.png"), height: 300.0),

          SizedBox(
            height: 5,
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
                  "Just a Second",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
                child: SpinKitWave(
                  color: Colors.amberAccent,
                  size: 50,
                  itemCount: 5,
                  type: SpinKitWaveType.start,
                )),
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () async {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// OutlineButton _facebookLoginButton() {
//   return OutlineButton(
//     splashColor: Colors.blue,
//     onPressed: () {
//       initiateFacebookLogin();
//     },
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//     highlightElevation: 0,
//     borderSide: BorderSide(color: Colors.blue),
//     child: Padding(
//       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image(image: AssetImage("images/fbiconbig.png"), height: 40.0),
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Text(
//               'Sign in with Facebook',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
