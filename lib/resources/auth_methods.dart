import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signupuser
  Future<String> signUpUser({
    required final String email,
    required final String password,
    required final String username,
    required final String bio,
    required final Uint8List file,
  }) async {
    String res = "Something going wrong!";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        //add user to our database
        // this will make a collection users and make a unique identification id and based on that will store the data.
        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', file, false);
        _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await _firestore.collection('users').doc(value.user!.uid).set({
            'username': username,
            'uid': value.user!.uid,
            'email': email,
            'bio': bio,
            'followers': [],
            'following': [],
            // 'photoUrl': photoUrl,
          });
        });
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
      debugPrint(res);
    }
    return res;
  }
}
