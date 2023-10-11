import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_users_firebase/videocalling/groupjoinn.dart';
import 'package:test_users_firebase/videocalling/joinn.dart';
import 'callservice.dart';
import 'package:test_users_firebase/videocalling/callservice.dart';

class videologin extends StatefulWidget {
  const videologin({super.key});

  @override
  State<videologin> createState() => _videologinState();
}

class _videologinState extends State<videologin> {
  @override
  int selectedIndex = 0;

  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        print(selectedIndex);
      });
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: TabBar(
            onTap: _onItemTapped,
            overlayColor:
                MaterialStatePropertyAll(Color.fromARGB(167, 195, 223, 247)),
            tabs: [
              Tab(
                child: Text(
                  "one-on-one meeting",
                  style: GoogleFonts.nunitoSans(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Group meeting",
                  style: GoogleFonts.nunitoSans(color: Colors.black),
                ),
              ),
            ]),
        body: Center(
          child: selectedIndex == 0 ? joinn() : groupjoinn(),
        ),
      ),
    );
  }
}
