import 'package:google_fonts/google_fonts.dart';
import 'package:test_users_firebase/videocalling/callservice.dart';
import 'package:flutter/material.dart';
import 'package:test_users_firebase/videocalling/groupcallservice.dart';

class groupjoinn extends StatelessWidget {
  const groupjoinn({super.key});
  static String username = "";
  static String userid = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 320,
              child: Image.asset(
                "lib/assets/3d2.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                style: GoogleFonts.nunitoSans(),
                onChanged: (value) {
                  username = value;
                  print(username);
                },
                decoration: const InputDecoration(
                  hintText: "Enter Username",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                style: GoogleFonts.nunitoSans(),
                onChanged: (value) {
                  userid = value;
                },
                decoration: InputDecoration(hintText: "Enter group ID"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const groupCallPage(
                        callID: "1",
                      ), /////////////
                    ));
                  },
                  child: Text(
                    "Join group meeting",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
