// ignore_for_file: camel_case_types, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Equipo/team_add.dart';
import 'package:app_flutter/nav.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class team_home extends StatelessWidget {
  final DocumentSnapshot th;
  team_home({required this.th,});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _teamhome(thuno: th),
    );
  }
}

class _teamhome extends StatefulWidget {
  final DocumentSnapshot thuno;
  _teamhome({required this.thuno});
  @override
  State<_teamhome> createState() => teamhome();
}

class teamhome extends State<_teamhome> {
  late CollectionReference ref = 
  FirebaseFirestore.instance
  .collection('Proyecto')
  .doc(widget.thuno.id)
  .collection('equipo');

  @override
  Widget build(BuildContext context) => 
  Scaffold(
    drawer: NavigationDrawerWidget(op: widget.thuno),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xff26282c),
      title: Text('Equipo',
      style: TextStyle(
        color: Colors.white, fontSize: 25, fontFamily: "Georgia"),
      ),
    ),
    backgroundColor: Color(0x222222),
    body: FutureBuilder<QuerySnapshot>(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.docs.length == 0) {
            return Center(
              child: Text(
                "No hay colaboradores registrados",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            );
          }
        }
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                .collection('Proyecto')
                .doc(widget.thuno.id)
                .collection('equipo')
                .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return Center( child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot datos = streamSnapshot.data!.docs[index];
                      return Slidable(
                        startActionPane: ActionPane(
                        extentRatio: 0.25,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                               label: 'Delete',
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              onPressed: ((context) {
                                 streamSnapshot.data!.docs[index].reference.delete().whenComplete(() 
                                =>  Navigator.pop(context));
                                 ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  content: Text('Actividad eliminada ', style: TextStyle(color: Color(0xff11b719)))));
                                }
                              )
                            )
                          ],
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(5.0),
                            child:Card(
                            child: Column(
                            children: <Widget>[
                              ListTile(
                                
                            leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            AssetImage("img/perfil.jpg"),
                                      ),
                                      
                            title:Text(datos["nombre"],
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          ),
                                     Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                          Expanded(
                                          flex: 10,
                                          child: Container(
                                          height: 25,
                                          child:Center(
                                          child: Text(datos["rol"],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                           ),
                          ),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4)
                                        ),
                                              color: Color.fromARGB(255, 95, 127, 153)
                                               ),
                                             )
                                            )
                                          ],
                                        ),
                                    ],
                                 ),
                            )
                        )
                      );
                    }
                  );
                }
              ),
            ),
          ),
        );
      }
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => team_add(ta: widget.thuno),)
        );
      },
      backgroundColor: Color.fromARGB(255, 95, 127, 153),
      child: const Icon(Icons.add),
      elevation: 2,
    ),
  );
}