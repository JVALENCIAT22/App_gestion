// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Proyecto/pro_home.dart';
import 'package:app_flutter/Actividad/act_home.dart';

class pro_info extends StatelessWidget {
  final DocumentSnapshot pinfo;
  pro_info({required this.pinfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _pro_info(pinfouno: pinfo),
    );
  }
}

class _pro_info extends StatefulWidget {
  final DocumentSnapshot pinfouno;
  _pro_info({required this.pinfouno});
  @override
  State<_pro_info> createState() => info();
}

class info extends State<_pro_info> {
  final _formkey = GlobalKey<FormState>();
  late String nombre = widget.pinfouno['nombre'];
  late String cliente = widget.pinfouno['cliente'];
  late Timestamp i = widget.pinfouno['f_inicio'];
  late Timestamp f = widget.pinfouno['f_fin'];
  late DateTime ini = i.toDate();
  late DateTime fin = f.toDate();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar datos'),
        centerTitle: true,
        backgroundColor: const Color(0xff26282c),
      ),
      backgroundColor: const Color(0x00222222),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text('Proyecto',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: nombre,
                            validator: (value) =>
                            value!.isEmpty ? "Campo requerido" : null,
                            onChanged: (String value) {
                              nombre = value;
                            },
                            decoration: const InputDecoration(
                              filled: true, 
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(  
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Proyecto",
                              prefixIcon: Icon(Icons.folder, 
                              color: Colors.grey
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text( 'Cliente',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: cliente,
                            validator: (value) =>
                            value!.isEmpty ? "Campo requerido" : null,
                            onChanged: (String value) {
                              cliente = value;
                            },
                            decoration: const InputDecoration(
                              filled: true, 
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Cliente",
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon( Icons.portrait,
                              color: Colors.grey
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                      const SizedBox(width: 15),
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
                      ]
                      ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // ignore: deprecated_member_use
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              upPro();
                              Navigator.push(context,MaterialPageRoute(
                                builder: (context) => pro_home()
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Proyecto actualizado', 
                                  style: TextStyle(color: Color(0xff11b719)))
                                )
                              );
                            } else {
                              print("error");
                            }
                          },
                          child: const Text("Actualizar",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    )
                  ]
                ),
              ]
            )  
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Proyecto").doc(widget.pinfouno.id);
        documentReference.delete().whenComplete(() => print("deleted successfully")
        );
        Navigator.push(context,
        MaterialPageRoute(builder: (context) =>pro_home()));
        },
         backgroundColor:  Color.fromARGB(255, 95, 127, 153),
        child: const Icon(Icons.delete,),
        elevation: 5,
      ),
    );
  }
  
  void upPro() async {
    DocumentReference ref = FirebaseFirestore.instance
    .collection('Proyecto')
    .doc(widget.pinfouno.id);
      
    var data = {
      'nombre': nombre,
      'cliente': cliente,
      'f_inicio': ini,
      'f_fin': fin,
    };
    ref.set(data);
  }
}
