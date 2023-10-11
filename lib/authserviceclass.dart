import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class authserviceclass {
  var isloggined = true;

  FirebaseAuth authinstance = FirebaseAuth.instance;

  void signin(String email, String password, String username,
      File? enteredimageauth, String designation) async {
    try {
      print(enteredimageauth);
      final usercredentials = await authinstance.createUserWithEmailAndPassword(
          email: email, password: password);

      print(' enteredimageauth = ${enteredimageauth.toString()}');
      //storing images/////////////////////////////////////////////////////////
      final usercredentialsimage = FirebaseStorage.instance
          .ref()
          .child("user images")
          .child("${usercredentials.user!.uid}.jpg");

      await usercredentialsimage.putFile(enteredimageauth!);
      final imageurl = await usercredentialsimage.getDownloadURL();
      print(' image string is  ${imageurl}');

      ////// creating and storing folder containing user data
      adduserdetails(username, email, password, imageurl, designation);
    } catch (e) {
      Text("couldnt sign in");
    }
  }

  void login(String email, String password) async {
    try {
      await authinstance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Text("couldnt log in");
    }
  }

  void logout() {
    authinstance.signOut();
    /*  return loginorsignup(); */
  }

  Future adduserdetails(String username, String email, String password,
      String image, String designation) async {
    await FirebaseFirestore.instance.collection("users").add(
      {
        "username": username,
        "email": email,
        "password": password,
        "uid": authinstance.currentUser!.uid,
        "image": image,
        "designation": designation,
      },
    );
  }
}
