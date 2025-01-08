import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up method
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'Some errors occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
            // register user
            UserCredential cred = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
            
            // add user to database
            await _firestore.collection('user').doc(cred.user!.uid).set({
              'username': username,
              'uid': cred.user!.uid,
              'email': email,
              'password': password,
              'bio': bio,
              'followers': [],
              'following': [],
            });
            res = "success";
          }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
