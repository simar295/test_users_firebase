import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_users_firebase/authserviceclass.dart';
import 'package:test_users_firebase/upperrow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_users_firebase/userlist.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //so if you want to access all unique id names of users then u can use this function and add each id to
  //to a simple list which will be displayed easily can a listviewbuilder or futurebuilder specifically.

/*   List<String> docids = [];

  Future getdocid() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.reference.id);
              docids.add(element.reference.id);
            }));
  }

  @override
  void initState() {
    getdocid();
    super.initState();
  }

      //used future  builder  only bcoz to wait for getdocid() function to complete
            /*  Expanded(
                child: FutureBuilder(
              future: getdocid(), //means to wait for this function to complete
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docids.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(docids[index]),
                    );
                  },
                );
              },
            )), */
 */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 246, 255),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 140,
          backgroundColor: Color.fromARGB(255, 240, 246, 255),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Convos",
                style: GoogleFonts.sacramento(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Row(
                children: [
                  Text("A Messenger Community App",
                      style: GoogleFonts.sacramento(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 238, 52, 108))),
                ],
              )
            ],
          ),
          actions: const [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.cable_outlined,
              size: 20,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.data_usage_rounded,
              size: 20,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(
              width: 10,
            ),

            /*  IconButton(
                onPressed: () {
                  authserviceclass().logout();
                },
                icon: Icon(Icons.login_outlined)) */
          ],
        ),
        body: const Column(
          children: [
            userlist(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            authserviceclass().logout();
          },
          child: const Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
