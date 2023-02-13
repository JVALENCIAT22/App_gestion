import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Autentication/aut.dart';
import 'package:app_flutter/Proyecto/pro_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  get toggleScreen => null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user !=null){
      return pro_home();
    }else{
      return Authentication();
    }
    
  }

  
}