import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

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
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadPictureToStorage('profilePics', file, false);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            password: password,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        // add user to database
        // old
        // await _firestore.collection('user').doc(cred.user!.uid).set({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'password': password,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        //   'photoUrl': photoUrl,
        // });

        // new
        await _firestore.collection('user').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    }
    // on FirebaseAuthException catch(e){
    //   if (e.code == 'invalid-email'){
    //     res = "The email ís badly formatted!";
    //   } else if (e.code == 'weak-password'){
    //     res = "Password should be at least 6 characters!";
    //   }
    // }
    catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some errors occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
