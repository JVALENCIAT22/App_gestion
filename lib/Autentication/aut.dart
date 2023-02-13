// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:app_flutter/Autentication/login.dart';

class Authentication extends StatefulWidget{
  @override
  _AuthenticationState createState()=> _AuthenticationState();
  logout() {}
}

class _AuthenticationState extends State<Authentication>{
  bool isToggle = false;
  void toggleScreen(){
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Login();
  }
  static Future signOut() async {}
}

Future signOut()async{
  try {
    return _AuthenticationState.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
}