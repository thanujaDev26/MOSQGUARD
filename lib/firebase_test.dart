import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest {
  static Future<void> testConnection() async {
    try {
      await FirebaseFirestore.instance.collection('test').add({'message': 'Hello from FirebaseTest!'});
      print("✅ Firebase is connected successfully!");
    } catch (e) {
      print("❌ Firebase connection failed: $e");
    }
  }
}
