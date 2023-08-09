import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_users_firebase/authserviceclass.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  
  //so if you want to access all unique id names of users then u can use this function and add each id to
  //to a simple list which will be displayed easily can a listviewbuilder or futurebuilder specifically.

  List<String> docids = [];

  Future getdocid() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.reference);
              docids.add(element.reference.id);
            }));
  }

  @override
  void initState() {
    getdocid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("homepage"),
          actions: [
            IconButton(
                onPressed: () {
                  authserviceclass().logout();
                },
                icon: Icon(Icons.login_outlined))
          ],
          //used future  builder  only bcoz to wait for getdocid() function to complete
        ),
        body: Column(
          children: [

            Expanded(
                child: FutureBuilder(
              future: getdocid(), //means to wait for this function to complete
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docids.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(docids[index]),);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
