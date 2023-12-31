import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_users_firebase/splashscreen.dart';
import 'videocalling/videologin.dart';
import 'chatpage.dart';
import 'dart:math' as math;

class userlist extends StatefulWidget {
  const userlist({super.key});

  @override
  State<userlist> createState() => _userlistState();
}

class _userlistState extends State<userlist> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? docrow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          var docs = snapshot.data!.docs;

          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                if (FirebaseAuth.instance.currentUser?.email ==
                    docs[index]['email']) {
                  return const SizedBox();
                } else {
                  return Card(
                    elevation: 0,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Color.fromARGB(255, 255, 3, 78),
                                width: 3),
                          ),
                        ),
                        child: ListTile(
                          subtitle: Text(
                            docs[index]["designation"],
                            style: GoogleFonts.nunitoSans(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => chatpage(
                                  getimage: docs[index]["image"],
                                  getuseremail: docs[index]["email"],
                                  getuserid: docs[index]["uid"],
                                  getusername: docs[index]["username"]),
                            ));
                          },
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.circle_rounded,
                              color: Color.fromARGB(255, 5, 146, 78),
                              size: 15,
                            ),
                          ),
                          title: Text(
                              /*  FirebaseAuth.instance.currentUser!.uid ==
                                      docs[index]['uid']
                                  ? "myself"
                                  : */
                              docs[index]["username"],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(docs[index]["image"]),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }

              /*      
                 Card(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(
                      color: Colors.greenAccent,
                    ),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                  elevation: 0,
                  margin: EdgeInsets.all(15),
                  child: ListTile(
                    subtitle: Text(
                      "start chatting",
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => chatpage(
                            getuseremail: docs[index]["email"],
                            getuserid: docs[index]["uid"],
                            getusername: docs[index]["username"]),
                      ));
                    },
                    title: Text(docs[index]["username"],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(docs[index]["image"]),
                    ),
                  ),
                ); */

              );
        },
      ),
    );
  }
}

/*
//fetching details of current user
  final user = firebaesauth.instance.currentuser!;
  final userdata = await firebasefirestore.instance.collection("users").doc(user.uid).get();

  firebasefirestore.instance.collection("chat").add({
    'text':messagecontroller.text,
    userid:user.uid
    username:userdata.data()!["username"]
  })

*/

