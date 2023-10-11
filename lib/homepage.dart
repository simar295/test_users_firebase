import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_users_firebase/authserviceclass.dart';
import 'package:test_users_firebase/upperrow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_users_firebase/userlist.dart';
import 'package:test_users_firebase/videocalling/videologin.dart';

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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 140,
          backgroundColor: _selectedIndex == 0
              ? Color.fromARGB(255, 240, 246, 255)
              : Color.fromRGBO(255, 237, 255, 1),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Convos",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Row(
                children: [
                  Text("Engineering Department",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 7, 156, 255))),
                  SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.computer,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
          actions: [
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
            IconButton(
                onPressed: () {
                  authserviceclass().logout();
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 20,
                )),
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
        body: _selectedIndex == 0
            ? Column(
                children: [
                  /*  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "  Engineering department    ",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.computer)
                        ],
                      )), */
                  const SizedBox(
                    height: 20,
                  ),
                  userlist(),
                ],
              )
            : videologin(),
        /* floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              authserviceclass().logout();
            },
            child: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ), */
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                activeIcon: Icon(
                  Icons.chat,
                  color: Color.fromARGB(206, 0, 119, 255),
                ),
                backgroundColor: Color.fromARGB(255, 195, 227, 253),
                label: "chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_call,
                ),
                activeIcon: Icon(
                  Icons.video_call,
                  color: Color.fromARGB(255, 255, 0, 34),
                ),
                label: "schedule meetings",
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ],
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            showUnselectedLabels: true,
            unselectedFontSize: 10,
            unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 0, 0, 0),
            iconSize: 35,
            selectedLabelStyle:
                GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }
}
