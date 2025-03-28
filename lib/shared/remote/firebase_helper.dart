//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

import 'package:smartirregation/shared/local/cache_helper.dart';

class FirebaseHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Sign Up
  static Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      insertRealtimeData(path: "/users/${userCredential.user!.uid}", data: {
        "email": email,
        "name": userCredential.user!.displayName,
        "photoURL": userCredential.user!.photoURL
      });

      await CacheHelper.setData(key: "uid", value: userCredential.user!.uid);
      await CacheHelper.setData(key: "userInfo", value: {
        "email": email,
        "name": userCredential.user!.displayName,
        "photoURL": userCredential.user!.photoURL
      });

      return null;
    } catch (e) {
      print("Sign Up Error: $e");
      return e.toString();
    }
  }

  // Login
  static Future<String?> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await CacheHelper.setData(key: "uid", value: userCredential.user!.uid);
      await CacheHelper.setData(key: "userInfo", value: {
        "email": email,
        "name": userCredential.user!.displayName,
        "photoURL": userCredential.user!.photoURL
      });

      return null;
    } catch (e) {
      print("Login Error: $e");
      return e.toString();
    }
  }

  // Logout
  static Future<String?> logout() async {
    try {
      await _auth.signOut();
      await CacheHelper.removeData(key: "uid");
      await CacheHelper.removeData(key: "userInfo");
      return null;
    } catch (e) {
      print("Logout Error: $e");
      return e.toString();
    }
  }

  // Forgot Password
  static Future<String?> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      print("Logout Error: $e");
      return e.toString();
    }
  }

  /*
  // Insert Data (Firestore)
  static Future<void> insertData({required String collection, required String docId, required Map<String, dynamic> data}) async {
    await _firestore.collection(collection).doc(docId).set(data);
  }

  // Update Data (Firestore)
  static Future<void> updateData({required String collection, required String docId, required Map<String, dynamic> data}) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  // Delete Data (Firestore)
  static Future<void> deleteData({required String collection, required String docId}) async {
    await _firestore.collection(collection).doc(docId).delete();
  }

  // Select Data (Firestore)
  static Future<DocumentSnapshot?> getData({required String collection, required String docId}) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(collection).doc(docId).get();
      return doc.exists ? doc : null;
    } catch (e) {
      print("Get Data Error: $e");
      return null;
    }
  }

  // Get All Documents (Firestore)
  static Future<List<QueryDocumentSnapshot>> getAllDocuments({required String collection}) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collection).get();
      return querySnapshot.docs;
    } catch (e) {
      print("Get All Documents Error: $e");
      return [];
    }
  }
  */

  // Upload File
  static Future<String?> uploadFile(
      {required String path, required File file}) async {
    try {
      TaskSnapshot snapshot = await _storage.ref(path).putFile(file);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Upload File Error: $e");
      return null;
    }
  }

  // Delete File
  static Future<void> deleteFile({required String path}) async {
    try {
      await _storage.ref(path).delete();
    } catch (e) {
      print("Delete File Error: $e");
    }
  }

  // Insert Data (Realtime Database)
  static Future<void> insertRealtimeData(
      {required String path, required dynamic data}) async {
    await _database.ref(path).set(data);
  }

  // Update Data (Realtime Database)
  static Future<void> updateRealtimeData(
      {required String path, required Map<String, Object?>  data}) async {
    await _database.ref(path).update(data);
  }

  // Delete Data (Realtime Database)
  static Future<void> deleteRealtimeData({required String path}) async {
    await _database.ref(path).remove();
  }

  // Select Data (Realtime Database)
  static Future<DataSnapshot?> getRealtimeData({required String path}) async {
    try {
      DatabaseEvent event = await _database.ref(path).once();
      return event.snapshot;
    } catch (e) {
      print("Get Realtime Data Error: $e");
      return null;
    }
  }
}
