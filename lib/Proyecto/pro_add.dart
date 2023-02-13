// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Proyecto/pro_home.dart';

class pro_add  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _pro_add(),
    );
  }
}

class _pro_add extends StatefulWidget {
  @override
  State<_pro_add> createState() => addpro();
}

class addpro extends State<_pro_add> {
  final _formkey = GlobalKey<FormState>();
  String nombre = '';
  String cliente = '';
  late DateTime ini = DateTime.now();
  late DateTime fin = DateTime.now().add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Proyecto'),
        centerTitle: true,
        backgroundColor: Color(0xff26282c),
      ),
      backgroundColor: Color(0x222222),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                    Text(
                    'Proyecto',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                  ),
                   const SizedBox(height: 10),
                   TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Campo requerido" : null,
                    onChanged: (String value) {
                      nombre = value;
                    },
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Proyecto",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                                    Icons.folder, 
                                    color: Colors.grey
                                    ),
                    ),
                  ),
                   const SizedBox(height: 10),
                   Text(
                    'Cliente',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                  ),
                   const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Campo requerido" : null,
                    onChanged: (String value) {
                      cliente = value;
                    },
                    decoration: InputDecoration(
                       filled: true, 
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Cliente",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                                    Icons.portrait, 
                                    color: Colors.grey
                                    ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                              Text('Fecha inicio',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                              ),
                              ),
                              const SizedBox(width: 90),
                              Text('Fecha fin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                              ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector( 
                          onTap: () async {
                            DateTime? nuevo = await showDatePicker(
                              context: context, 
                              initialDate: ini,
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(2100)
                            );
                            if (nuevo == null) return;
                            setState(() {
                              ini = nuevo;
                            });
                          },
                          child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                          filled: true, 
                          fillColor: Colors.white,
                          labelStyle:TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(Icons.calendar_month,
                          color: Colors.grey),
                          hintText: '${ini.day}/${ini.month}/${ini.year}',
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          )
                          ),
                        ),
                        )
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector( 
                          onTap: () async {
                            DateTime? nuevo = await showDatePicker(
                              context: context, 
                              initialDate: ini,
                              firstDate: ini, 
                              lastDate: DateTime(2100)
                            );
                            if (nuevo == null) return;
                            setState(() {
                              fin = nuevo;
                            });
                          },
                          child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                          filled: true, 
                          fillColor: Colors.white,
                          labelStyle:TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(Icons.calendar_month,
                          color: Colors.grey),
                          hintText: '${fin.day}/${fin.month}/${fin.year}',
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          )
                          ),
                        ),
                        )
                      ),
                    ],
                  ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // ignore: deprecated_member_use
                      ElevatedButton(
                        onPressed: () {
                           if (_formkey.currentState!.validate()) {
                              addPro();
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => pro_home()),
                              );
                          } else {
                            print("error");
                          }
                        },
                        child: Text("Agregar",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        )
      )
    );
  }
  
  void addPro() async {
    CollectionReference ref = FirebaseFirestore.instance
      .collection('Proyecto');
      
      var data = {
      'nombre': nombre,
      'cliente': cliente,
      'f_inicio': ini,
      'f_fin': fin,
      };
      
      ref.add(data);
  }
}
                        
                        
                          
