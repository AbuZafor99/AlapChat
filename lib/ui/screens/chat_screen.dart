import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import '../../services/database.dart';
import '../../services/shared_pref.dart';

class ChatScreen extends StatefulWidget {
  String name, profileUrl,userName;
  ChatScreen({required this.name, required this.profileUrl, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String? myUserName, myName, myEmail, myPicture, chatRoomId, messageId;
  TextEditingController messageTEController=TextEditingController();

  getDataFromSharedPref()async{
    myUserName= await SharedPreferenceHelper().getUserName();
    myName=await SharedPreferenceHelper().getUserDisplayName();
    myEmail=await SharedPreferenceHelper().getUserEmail();
    myPicture= await SharedPreferenceHelper().getUserImage();

    chatRoomId=getChatRoomIdByUserName(widget.userName, myUserName!);
    setState(() {});
  }
  @override
  void initState() {
    getDataFromSharedPref();
    super.initState();
  }
  getChatRoomIdByUserName(String a, String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) async {
    if (messageTEController.text != "") {
      String message=messageTEController.text;
      messageTEController.text="";

      DateTime now =DateTime.now();
      String formattedDate=DateFormat("h:mma").format(now);

      Map<String,dynamic> messageInfoMap={
        "message":message,
        "sendBy":myUserName,
        "ts":formattedDate,
        "time":FieldValue.serverTimestamp(),
        "image":myPicture,
      };
      messageId=randomAlphaNumeric(15);
      await DatabaseMethods().addMessage(chatRoomId!, messageId!, messageInfoMap).then((value){
          Map<String,dynamic> lastMessageInfoMap={
            "lastMessage":message,
            "lastMessageSendTs":formattedDate,
            "time":FieldValue.serverTimestamp(),
            "lastMessageSendBy":myUserName
          };
          DatabaseMethods().updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
          if(sendClicked){
            message="";
          }
        }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff703eff),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5.2),
                  Text(
                    "Aminul Islam",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Hey. How are you? ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Hello. I'm fine. How are you? ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/1.8),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xff703eff),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Icon(
                              Icons.mic,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffececf8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                                child: TextField(
                                  controller: messageTEController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hint: Text("Write a message...",),
                                    suffixIcon: Icon(Icons.attach_file)
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xff703eff),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Icon(
                              Icons.send,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
