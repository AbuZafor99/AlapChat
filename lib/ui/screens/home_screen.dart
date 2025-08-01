import 'package:chatting_app_flutter_firebase/services/database.dart';
import 'package:chatting_app_flutter_firebase/services/shared_pref.dart';
import 'package:chatting_app_flutter_firebase/ui/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? myUserName, myName, myEmail, myPicture;
  TextEditingController searchTEController = TextEditingController();
  bool search = false;

  getDataFromSharedPref() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    myName = await SharedPreferenceHelper().getUserDisplayName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    myPicture = await SharedPreferenceHelper().getUserImage();

    setState(() {});
  }

  @override
  void initState() {
    getDataFromSharedPref();
    super.initState();
  }

  

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Stream? searchResultsStream;

  initiateSearch() {
    if (searchTEController.text.isNotEmpty) {
      setState(() {
        searchResultsStream =
            DatabaseMethods().searchUsers(searchTEController.text);
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff703eff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/wave.png",
                  height: 50,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(
                  "Hello,",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  myName.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: "name",
                          profileUrl: "profileUrl",
                          userName: "userName",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Color(0xff703eff),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Welcome To",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(197, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "AlapChat",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Material(
                      elevation: 1,
                      shadowColor: Color(0xffb8b7ce),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: searchTEController,
                          onChanged: (value) {
                            initiateSearch();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search Username...",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder(
                      stream: searchResultsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final filteredDocs = snapshot.data!.docs.where((doc) => doc['userName'] != myUserName).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemCount: filteredDocs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = filteredDocs[index];
                              return buildResultCard(ds);
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Color(0xffb8b7ce),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                "assets/images/boy.jpg",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "Aminul Islam",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Hi. How are you?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(151, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "2.00 PM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResultCard(DocumentSnapshot ds) {
    return GestureDetector(
      onTap: () async {
        search = false;
        var chatRoomId = getChatRoomIdByUserName(myUserName!, ds['userName']);
        Map<String, dynamic> chatInfoMap = {
          "users": [myUserName, ds["userName"]],
        };
        await DatabaseMethods().createChatRoom(chatRoomId, chatInfoMap);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: ds["Name"],
              profileUrl: ds["Image"],
              userName: ds["userName"],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    ds["Image"],
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      ds["Name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ds["userName"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(151, 0, 0, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
