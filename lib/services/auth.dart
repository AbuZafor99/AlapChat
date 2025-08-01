import 'package:chatting_app_flutter_firebase/services/database.dart';
import 'package:chatting_app_flutter_firebase/services/shared_pref.dart';
import 'package:chatting_app_flutter_firebase/ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;
    String userName=userDetails!.email!.replaceAll("@gmail.com", "");
    String firstletter =userName.substring(0,1).toUpperCase();

    await SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName!);
    await SharedPreferenceHelper().saveUserImage(userDetails.photoURL!);
    await SharedPreferenceHelper().saveUserEmail(userDetails.email!);
    await SharedPreferenceHelper().saveUserId(userDetails.uid);
    await SharedPreferenceHelper().saveUserName(userName);

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "Name": userDetails!.displayName,
        "Email": userDetails!.email,
        "Image": userDetails.photoURL,
        "Id": userDetails.uid,
        "userName":userName.toUpperCase(),
        "SearchKey":firstletter
      };
      await DatabaseMethods().addUser(userInfoMap, userDetails!.uid).then((
        value,
      ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registration successful.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        Navigator.pushNamed(context, HomeScreen.name);
      });
    }
  }
}
