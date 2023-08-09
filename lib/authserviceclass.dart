import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class authserviceclass {
  var isloggined = true;

  FirebaseAuth authinstance = FirebaseAuth.instance;

  void signin(String email, String password,String username) async {
    try {
      await authinstance.createUserWithEmailAndPassword(
          email: email, password: password);

      adduserdetails(username, email, password);
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

  Future adduserdetails(String username, String email, String password) async {
    await FirebaseFirestore.instance
        .collection("users")
        .add({"username": username, "email": email, "password": password});
  }
}
