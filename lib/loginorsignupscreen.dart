import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_users_firebase/authserviceclass.dart';

import 'imagewidget.dart';

class loginorsignup extends StatefulWidget {
  const loginorsignup({super.key});

  @override
  State<loginorsignup> createState() => _loginorsignupState();
}

class _loginorsignupState extends State<loginorsignup> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  File? enteredimage;
  var isloggined = authserviceclass().isloggined;
  var isauth = false;

  signinhere(
      String email, String password, String username, File enteredimage) async {
    setState(() {
      isauth = true;
    });
    authserviceclass().signin(email, password, username, enteredimage);
  }

  loginhere(String email, String password) async {
    setState(() {
      isauth = true;
    });
    authserviceclass().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Icon(Icons.wechat_outlined, size: 70),
              Text(
                isloggined ? "welcome back !" : "sign up for an account",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              if (!isloggined)
                imagewidget(
                  getpickedimage: (pickedimage) {
                    enteredimage = pickedimage;
                  },
                ),
              if (!isloggined)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 219, 219, 219),
                  ),
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                        labelText: " add  username", border: InputBorder.none),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 219, 219, 219),
                ),
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: isloggined ? " email" : "add email address",
                      border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 219, 219, 219),
                ),
                margin: EdgeInsets.fromLTRB(30, 0, 30, 5),
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                      labelText: isloggined ? "  password" : "add password",
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  if (!isloggined) {
                    signinhere(emailcontroller.text, passwordcontroller.text,
                        usernamecontroller.text, enteredimage!);
                  }
                  if (isloggined) {
                    loginhere(emailcontroller.text, passwordcontroller.text);
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 330,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 82, 255, 91),
                          Color.fromARGB(255, 125, 144, 248)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 219, 219, 219),
                    ),
                    child: isauth
                        ? CircularProgressIndicator()
                        : Text(
                            isloggined ? "login" : "sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isloggined = !isloggined;
                      print("logged in");
                    });
                  },
                  child: Text(isloggined
                      ? " dont have any account ? Sign up"
                      : "already have an account?? Log in")),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Convos",
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              ),
              Text("A messenger  community app",
                  style: TextStyle(
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[
                            Colors.pinkAccent,
                            Colors.deepPurpleAccent,
                            Colors.red
                            //add more color here.
                          ],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)))),
            ],
          ),
        ),
      )),
    ));
  }
}
