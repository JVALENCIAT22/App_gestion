// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Equipo/team_home.dart';

class team_add extends StatelessWidget {
  final DocumentSnapshot ta;
  team_add({required this.ta});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _team_add(tauno: ta),
    );
  }
}

class _team_add extends StatefulWidget {
  final DocumentSnapshot tauno;
  _team_add({required this.tauno});
  @override
  State<_team_add> createState() => addteam();
}

class addteam extends State<_team_add> {
  final _formkey = GlobalKey<FormState>();
  var nombre;
  String rol = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Equipo'),
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
                  const SizedBox(height: 20),
                  Text('Integrante',
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Georgia"),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Colaboradores').snapshots(),
                  builder: (context, streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Center( child: CircularProgressIndicator());
                    }
                    List<DropdownMenuItem> itemsbd = [];
                    for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                      DocumentSnapshot lista = streamSnapshot.data!.docs[i];
                      itemsbd.add(
                        DropdownMenuItem(
                          child: Text(lista['nombre'],
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
                          value: "${lista['nombre']}",
                        ),
                      );
                      }
                      return DropdownButtonFormField<dynamic>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      items: itemsbd,
                      onChanged: (valor) {
                        setState(() {
                        nombre = valor;
                        });
                      },
                      value: nombre,
                      hint: Text("Seleccione un integrante",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      validator: (item) {
                        if (item == null) {
                          return "Campo requerido";
                          }
                          else {
                            return null;
                          }
                      },
                      );
                    }
                  ),
                  const SizedBox(height: 20),
                  Text('Rol',
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Georgia"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) =>
                    value!.isEmpty ? "Campo requerido" : null,
                    onChanged: (String value) {
                      rol = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Rol",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.group_add,
                        color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          addTeam();
                          nombre = '';
                          rol = '';
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => team_home(th: widget.tauno)
                          ),
                          );
                        } else {
                          print("error");
                        }
                      },
                      child: Text("Agregar",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      );
    }

  void addTeam() async {
      CollectionReference ref = FirebaseFirestore.instance
      .collection('Proyecto')
      .doc(widget.tauno.id)
      .collection('equipo');
      
      var data = {
        'nombre': nombre,
        'rol': rol,
        'check': false,
      };
      ref.add(data);
    }
}
