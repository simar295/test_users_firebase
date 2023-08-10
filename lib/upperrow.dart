import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class upperow extends StatelessWidget {
  const upperow({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        var docs = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: docs.length),
          shrinkWrap: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            /*   if (FirebaseAuth.instance.currentUser!.email !=
                    docs[index]['email']) */
            return Container(
                width: 70,
                height: 70,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                        color: Color.fromARGB(255, 48, 255, 151), width: 2)),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(docs[index]["image"]),
                ));
          },
        );
      },
    ));
  }
}
