import 'package:chatting_app_flutter_firebase/ui/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String name="/";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children: [
            Image.asset("assets/images/onboard.png"),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Text("Enjoy the new Experience of chatting with global friends.",
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Text("Connect people around the world for free.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: onTapSignInButton,
              child: Container(
                margin: EdgeInsets.only(left: 30,right: 30),
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 30,top: 8,bottom: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff703eff),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/search.png",height: 50,width: 50,fit: BoxFit.cover,),
                        Text("Sign in with Google.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  void onTapSignInButton(){
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.name, (predicate)=>false);
  }
}
