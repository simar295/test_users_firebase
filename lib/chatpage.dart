import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chatservices.dart';

class chatpage extends StatefulWidget {
  const chatpage(
      {super.key,
      required this.getuseremail,
      required this.getuserid,
      required this.getusername,
      required this.getimage});

  final String getuseremail;
  final String getuserid;
  final String getusername;
  final String getimage;

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  @override
  final messagecontroller = TextEditingController();
  final chatservice chatserv = chatservice();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void sendmessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await chatserv.sendmessage(widget.getuserid, messagecontroller.text);
      messagecontroller.clear();
    }
  }

  /* void animatelist() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    super.initState();
  }
 */
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        super.initState();
      });
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/logo.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            title: Text(
              widget.getusername,
              style: GoogleFonts.inconsolata(),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.getimage),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_downward_rounded))
            ],
          ),
          body: Column(
            children: [
              //messages
              Expanded(child: buildmessagelist()),
              //userinput
              buildmessageinput(),
            ],
          ),
        ),
      ),
    );
  }

  //buildmessagelist
  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    setState(() {
      _controller.jumpTo(_controller.position.minScrollExtent);
    });
  }

  Widget buildmessagelist() {
////////////

///////////////
    return StreamBuilder(
      stream:
          chatserv.getmessages(widget.getuserid, firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading.....");
        }
        return ListView(
          /*   controller: _controller, */
          reverse: true,
          children:
              snapshot.data!.docs.map((e) => buildmessageitem(e)).toList(),
        );
      },
    );
  }

  //buildmessagelistitem
  Widget buildmessageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //setting alignment

    var alignment = (data["recieverid"] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      alignment: alignment,
      child: Column(
          crossAxisAlignment:
              (data["recieverid"] == firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
          children: [
            Text(data['timestamp']),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.black),
              child: Text(
                data['message'],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
    );
  }

  //buildmessageinput
  Widget buildmessageinput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 15),
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: messagecontroller,
              decoration: InputDecoration(
                  suffixIconColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.focused)
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : Color.fromARGB(255, 0, 0, 0)),
                  focusColor: Colors.greenAccent,
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendmessage();
                      /*  _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut); */
                    },
                    icon: Icon(
                      Icons.send_sharp,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 30,
                    ),
                  ),
                  labelText: "  Send message",
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }
}
