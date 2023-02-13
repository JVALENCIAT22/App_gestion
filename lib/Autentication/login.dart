// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:app_flutter/Autentication/services.dart';
import 'package:app_flutter/widgets/auth_background.dart';
import 'package:app_flutter/widgets/card_container.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key,  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
 bool _isVisible =false;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:Form(
               key: _formkey,
               child: Column(
                children: <Widget>[
                  const SizedBox(height: 220),
                  CardContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 20
                      ),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Login',
                                style: TextStyle(
                                fontSize: 30,
                                color:Colors.black)
                              ),
                            ],
                          ),
                           const SizedBox(height: 10),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Bienvenido de nuevo',
                                style: TextStyle(
                                fontSize: 15,
                                color:Colors.black)
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (String value) {
                              email.text = value;
                            },
                            validator: (value) =>
                            value!.isNotEmpty ? null : "Ingrese su correo",
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: !_isVisible,
                            onChanged: (String value) {
                              password.text = value;
                            },
                            validator: (value) => 
                            value!.length < 6 ? "Ingrese su contraseña" : null,
                           
                            decoration: InputDecoration(
                              hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            }, 
                            icon:  _isVisible ? Icon(Icons.visibility):Icon(Icons.visibility_off),),
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          MaterialButton(
                            onPressed: () async{
                              if (_formkey.currentState!.validate()) {
                                print("Email: ${email.text}");
                                print("Password: ${password.text}");
                                await loginProvider. login(
                                  email.text.trim(),
                                  password.text.trim(),
                                );
                              }
                            },
                            height: 40,
                            color: const Color.fromRGBO(38, 50, 56, 1),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container (
                              padding: EdgeInsets.symmetric(
                                horizontal: 60, 
                                vertical: 15
                              ),
                              child: const Text("Ingresar",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ] 
              )
            )
          )
        )
      )
    );
  }
}