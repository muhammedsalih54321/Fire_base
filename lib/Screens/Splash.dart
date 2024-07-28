import 'dart:async';


import 'package:fire_base/Screens/Login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   void islogin(){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;

    if (user!=null) {
       Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Loginpage())));
    }else{
       Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>Loginpage())));
    }
   
   }
  @override
 
  void initState() {

    super.initState();
   islogin();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(child: Image.asset('assets/images/img.png',height: 200,width:200,),)
      ],),
    );
  }
 
}
