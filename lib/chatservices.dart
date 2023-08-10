import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'messageclass.dart';

class chatservice {
  var getusername = "";

  //getting instance of auth and firestore

  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore firebasestore = FirebaseFirestore.instance;

  // method to send a message
  Future<void> sendmessage(String recieveridhere, String messagehere) async {
    // get current user info
    final String currentuserid = firebaseauth.currentUser!.uid;
    final String currentuseremail = firebaseauth.currentUser!.email.toString();
    final String timestamp =
        ' ${DateTime.now().hour}:${DateTime.now().minute} pm ';

    //create a new message

    messages newmessage = messages(
      username: getusername,
      senderemail: currentuserid,
      recieverid: recieveridhere,
      senderid: currentuseremail,
      message: messagehere,
      timestamp: timestamp,
      timestamps: Timestamp.now(),
    );

    //contruct a chat room id from currentuserid and reiveruserid (sort to ensure uniqueness that ex- [a,b] room will remain same in case of  [b,a])
    List<String> ids = [currentuserid, recieveridhere];
    ids.sort();
    //combining two ids to get one single chatroom id
    String chatroomid = ids.join("-");

    //add new message to database
    await firebasestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        ////here convert to map of class is getting used
        .add(newmessage.converttomap());
  }

  // get messages

  Stream<QuerySnapshot> getmessages(String userid, String otheruserid) {
    //contruct a chat room id from currentuserid and reiveruserid (sort to ensure uniqueness that ex- [a,b] room will remain same in case of  [b,a])
    List<String> ids = [userid, otheruserid];
    ids.sort();
    //combining two ids to get one single chatroom id
    String chatroomid = ids.join("-");

    return firebasestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        .orderBy('timestamps', descending: true)
        .snapshots();
  }


  //storing images
  
}
