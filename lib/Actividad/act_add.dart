// ignore_for_file: camel_case_types, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Actividad/act_home.dart';

class act_add extends StatelessWidget {
  final DocumentSnapshot actadd;
  act_add({required this.actadd});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _act_add(adduno: actadd),
    );
  }
}

class _act_add extends StatefulWidget {
  final DocumentSnapshot adduno;
  _act_add({required this.adduno});
  @override
  State<_act_add> createState() => addact();
}

class addact extends State<_act_add> {
  final _formkey = GlobalKey<FormState>();
  String metodo = "Estado de Actividad";
  Color col = Colors.white;
  bool check = false;
  late String actividad = widget.adduno['nombre'];
  late Timestamp i = widget.adduno['f_inicio'];
  late Timestamp f = widget.adduno['f_fin'];
  late DateTime addini = i.toDate();
  late DateTime addfin = f.toDate();

  var _lista = [
    'Por Hacer',
    'En Desarrollo',
    'Terminado',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Actividad'),
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
                    Text('Actividad',
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
                        actividad = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          )
                        ),
                        hintText: "Actividad",
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Estado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true, 
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            items: _lista.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value == 'Por Hacer'){
                                setState(() {
                                  metodo = value!;
                                  col = Colors.red;
                                });
                              } if (value == 'En Desarrollo'){
                                setState(() {
                                  metodo = value!;
                                  col = Colors.yellow;
                                });
                              } if (value == 'Terminado'){
                                setState(() {
                                  metodo = value!;
                                  col = Colors.green;
                                });
                              }
                            },
                            validator: (item) {
                              if (item == null) {
                                return "Campo requerido";
                                }
                                else {
                                  return null;
                                }
                            },
                            hint: Text(metodo,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Proyecto').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Center( child: CircularProgressIndicator());
                    }
                      Timestamp i = widget.adduno['f_inicio'];
                      Timestamp f = widget.adduno['f_fin'];
                      DateTime fei = i.toDate();
                      DateTime fef = f.toDate();

                      return Column(
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
                              initialDate: fei,
                              firstDate: fei, 
                              lastDate: fef
                            );
                            if (nuevo == null) return;
                            setState(() {
                              addini = nuevo;
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
                          hintText: '${addini.day}/${addini.month}/${addini.year}',
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
                              initialDate: addini,
                              firstDate: addini, 
                              lastDate: fef
                            );
                            if (nuevo == null) return;
                            setState(() {
                              addfin = nuevo;
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
                          hintText: '${addfin.day}/${addfin.month}/${addfin.year}',
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
                      ); 
                  }
                  ),
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            addAct();
                            actividad = '';
                            metodo = '';
                            Navigator.push(context,MaterialPageRoute(
                              builder: (context) => act_home(ah: widget.adduno)
                            ),
                            );
                          } else {
                            print("error");
                          }
                        },
                        child: Text("Agregar",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      )
                    )
                      /*Center(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              addAct();
                              actividad = '';
                              metodo = '';
                              Navigator.push(context,MaterialPageRoute(
                                builder: (context) => act_home(ah: widget.adduno)
                                ),
                              );
                            } else {
                              print("error");
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color.fromARGB(255, 95, 127, 153),
                          child: Text(
                            "Agregar",
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),*/
                    ],
                  ),
              )
              ),
            ),
          ),
      );
    }

    void addAct() async {
      CollectionReference ref = FirebaseFirestore.instance
      .collection('Proyecto')
      .doc(widget.adduno.id)
      .collection('actividad');
      
      var data = {
        'nombre': actividad,
        'metodo': metodo,
        'f_inicio': addini,
        'f_fin': addfin,
      };
      ref.add(data);
    }
}
                        
                        
                          
