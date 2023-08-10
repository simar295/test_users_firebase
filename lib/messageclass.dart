import 'package:cloud_firestore/cloud_firestore.dart';

class messages {
  messages({
    required this.username,
    required this.senderemail,
    required this.recieverid,
    required this.senderid,
    required this.message,
    required this.timestamp,
    required this.timestamps,
  });

  final String username;
  final String senderid;
  final String senderemail;
  final String recieverid;
  final String message;
  final String timestamp;
  final Timestamp timestamps;

  //a method to convert into map cuz info is stored in  map in firebase

  Map<String, dynamic> converttomap() {
    return {
      "senderid": senderid,
      "senderemail": senderemail,
      "recieverid": recieverid,
      "message": message,
      "timestamp": timestamp,
      "timestamps":timestamps
    };
  }
}
