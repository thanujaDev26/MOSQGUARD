import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../execptions/auth_exceptions.dart'; // Ensure this file exists

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? _verificationId;

  // ✅ Anonymous Login
  Future<void> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      final user = userCredential.user;
      if (user != null) {
        print("✅ Signed in Anonymously: ${user.uid}");
      }
    } on FirebaseAuthException catch (error) {
      print("❌ Anonymous Sign-In Error: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    } catch (error) {
      print("❌ Unknown Error during Anonymous Sign-In: $error");
    }
  }

  // ✅ Get Current User
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // ✅ Sign Out (Google + Firebase)
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      print("✅ User Signed Out");
    } on FirebaseAuthException catch (error) {
      print("❌ Sign-Out Error: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    } catch (error) {
      print("❌ Unknown Sign-Out Error: $error");
    }
  }

  // ✅ Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("⚠️ Google Sign-In canceled by user.");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      print("✅ Google Sign-In successful");
    } on FirebaseAuthException catch (error) {
      print("❌ Google Sign-In Error: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    } catch (error) {
      print("❌ Unknown Google Sign-In Error: $error");
    }
  }

  // ✅ Send OTP for Phone Authentication
  Future<void> sendOTP(String phoneNumber, Function onCodeSent) async {
    try {
      // Ensure phone number is in correct format (+1234567890)
      if (!phoneNumber.startsWith("+")) {
        print("⚠️ Phone number should be in E.164 format (+1234567890). Fixing it...");
        phoneNumber = "+$phoneNumber";
      }

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          print("✅ Auto-verification successful");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("❌ OTP Verification Failed: ${e.message}");
          throw Exception("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          print("✅ OTP Sent Successfully");
          onCodeSent();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print("⚠️ Auto-retrieval timeout");
        },
      );
    } on FirebaseAuthException catch (error) {
      print("❌ Firebase OTP Error: ${mapFirebaseAuthExceptionCodes(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCodes(error.code));
    } catch (error) {
      print("❌ Unknown Error Sending OTP: $error");
    }
  }

  // ✅ Verify the OTP
  Future<bool> verifyOTP(String smsCode) async {
    try {
      if (_verificationId == null) {
        print("❌ Error: Verification ID is null.");
        return false;
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _firebaseAuth.signInWithCredential(credential);
      print("✅ OTP Verified Successfully");
      return true;
    } on FirebaseAuthException catch (error) {
      print("❌ OTP Verification Error: ${mapFirebaseAuthExceptionCodes(error.code)}");
      return false;
    } catch (error) {
      print("❌ Unknown Error Verifying OTP: $error");
      return false;
    }
  }
}
