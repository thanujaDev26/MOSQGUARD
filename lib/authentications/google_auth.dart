import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mosqguard/authentications/database.dart';
import 'package:mosqguard/pages/dashboard/home.dart';

class AuthMethods {

  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUSer() async{
    return await auth.currentUser;
  }
  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      // User canceled the sign-in process
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if (userDetails != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "name": userDetails.displayName,
        "imgURL": userDetails.photoURL,
        "phone": userDetails.phoneNumber,
        "id": userDetails.uid
      };

      await DatabaseMethods().addUser(userDetails.uid, userInfoMap).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }
}