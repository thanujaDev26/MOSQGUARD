import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mosqguard/execptions/auth_exceptions.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Anonymous Login
  Future<void> signinInAnonymously() async{
    try{
      final UserCredential _userCredential = await _firebaseAuth.signInAnonymously();
      final user = _userCredential.user;

      if(user != null){
        print("Singed in Anonymously: ${user.uid}");
      }
    }
    on FirebaseAuthException catch (error){
      print("Error signing in anonymously: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    }
    catch(error){
      print("Anonymous Sign-In failed: ${error}");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Something went wrong: $error")),
      // );
    }
  }

  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async{
    try{
      await _firebaseAuth.signOut();
      print("Sign out");
    }

    on FirebaseAuthException catch (error){
      print("Error signing in anonymously: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    }
    catch(error){
      print("Error signing out: $error");
    }
  }


  Future<void> signinWithGoogle () async{
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null){
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      
      await _firebaseAuth.signInWithCredential(credential);
    }

    on FirebaseAuthException catch (error){
      print("Error signing in anonymously: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    }

    catch(error){
      print("Error signing out: $error");
    }
  }


}