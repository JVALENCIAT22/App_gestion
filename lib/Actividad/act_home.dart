// ignore_for_file: camel_case_types, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Actividad/act_add.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:app_flutter/nav.dart';

class act_home extends StatelessWidget {
  final DocumentSnapshot ah;
  act_home({required this.ah});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _act_home(ahuno: ah),
    );
  }
}

class _act_home extends StatefulWidget {
  final DocumentSnapshot ahuno;
  _act_home({required this.ahuno});
  @override
  State<_act_home> createState() => acthome();
}

class Colab{
  String ruta;
  String nombre;
  bool check;

  Colab({required this.ruta, required this.nombre, required this.check});
}

class acthome extends State<_act_home> {
  late CollectionReference ref = 
  FirebaseFirestore.instance
  .collection('Proyecto')
  .doc(widget.ahuno.id)
  .collection('actividad');

  late CollectionReference list =
  FirebaseFirestore.instance
  .collection('Proyecto');

  late CollectionReference add =
  FirebaseFirestore.instance.collection("Proyecto");

  Future listar(ruta, check, nombre) async {
    await list.doc(ruta).set({"check": check, "nombre": nombre});
  }

  Future agregar(ruta, check, nombre) async {
    await add.doc(ruta).set({"check": check, "nombre": nombre});
    
    print(widget.ahuno.id.toString());
  }

   Future reset() async {
    await list.doc().set({"check": false});
   }

  List<Colab> colabFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Colab(
          check: e["check"],
          nombre: e["nombre"],
          ruta: e.id
        );
      }).toList();
    } else {
      return colabFromFirestore(snapshot);
    }
  }

  Stream<List<Colab>> listColab() {
    return list.snapshots().map(colabFromFirestore);
  }
  
  var check;

  Color col = Color.fromARGB(255, 255, 255, 255);
  String usuario = '';
  var val;
  late String actividad = widget.ahuno['nombre'];
  late String metodo;
  late Timestamp i = widget.ahuno['f_inicio'];
  late Timestamp f = widget.ahuno['f_fin'];
  late DateTime actini = i.toDate();
  late DateTime actfin = f.toDate();

  final _lista = [
    'Por Hacer',
    'En Desarrollo',
    'Terminado',
  ];

  @override
  Widget build(BuildContext context) => 
  Scaffold(
    drawer: NavigationDrawerWidget(op: widget.ahuno),
    appBar: AppBar(
      centerTitle: true,
      title: Text(widget.ahuno["nombre"],
      style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: Color(0xff26282c),
    ),
    backgroundColor: Color(0x222222),
    body: FutureBuilder<QuerySnapshot>(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.docs.length == 0) {
            return const Center(
              child: Text(
                "No tienes actividades registradas",
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
            padding: const EdgeInsets.all(5.0),
            child: SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                .collection('Proyecto')
                .doc(widget.ahuno.id)
                .collection('actividad')
                .orderBy('nombre')
                .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator()
                    );
                  }    
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ahdos = streamSnapshot.data!.docs[index];
                      
                      Timestamp i = ahdos['f_inicio'];
                      Timestamp f = ahdos['f_fin'];
                      DateTime fi = i.toDate();
                      DateTime ff = f.toDate();
                      
                      return  Slidable(
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
                                  content: Text('Actividad eliminada ', style: TextStyle(color: Color(0xff11b719)))
                                  ));
                                }
                              )
                            )
                          ],
                        ),
                       child: Padding(
                          padding: const EdgeInsets.all(5.0),
                            child: Card(
                              child: Column(
                            children: <Widget>[
                           ListTile(
                            title:Text(ahdos["nombre"],
                            style:const TextStyle(fontSize: 18, color: Colors.black
                            ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Icons.calendar_month,
                                size: 18,),
                                const SizedBox(width: 5, height: 30),
                                Text('${fi.day}/${fi.month}/${fi.year}   -   ${ff.day}/${ff.month}/${ff.year} ',
                                 style:const TextStyle(fontSize: 15, color: Colors.black
                                  ),
                                ),
                                const SizedBox(width: 50, height: 30),
                                IconButton(
                                  icon: Icon(Icons.group),
                                  onPressed: (){
                                showDialog(
                                  context: context, 
                                  builder: (context)=>
                                  Dialog(
                                    child: Container(
                                      color: Colors.black.withOpacity(0.8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                          child: StreamBuilder<List<Colab>>(
                            stream: acthome().listColab(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator()
                                  );
                                }
                                List<Colab> lista = snapshot.data!;
                                return Padding(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.white,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: lista.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                    onTap: () {
                                      setState(() {
                                        final newValue = !check;
                                        check = newValue;
                                        });
                                        acthome().listar(lista[index].ruta, check, lista[index].nombre);
                                        acthome().agregar(lista[index].ruta, check, lista[index].nombre);
                                    },
                                  leading: Checkbox(
                                  autofocus: false,
                                  value: lista[index].check,
                                  checkColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      check = value!;
                                      acthome().listar(lista[index].ruta, check, lista[index].nombre);
                                      acthome().agregar(lista[index].ruta, check, lista[index].nombre);
                                  },
                                  );
                                 },
                                ),
                                title: Text(
                                  lista[index].nombre,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                                  );
                                }
                              ) 
                            ]
                            )
                          );
                        }
                        ),
                        )
                          ],
                        ),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                      ]
                    ),
                  ),
                ),
              )
            );
          },
        ),
      ],
    ),
    trailing: Builder(builder: (context) {
      Timestamp ini = ahdos['f_inicio'];
      Timestamp fin = ahdos['f_fin'];
      DateTime fini = ini.toDate();
      DateTime ffin = fin.toDate();
      DateTime ahora = DateTime.now();
      
      if(ahdos['metodo'] == 'Por Hacer'){
        if(fini.isAfter(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.green
            )
          );
        } if('${fini.day}/${fini.month}/${fini.year}' == '${ahora.day}/${ahora.month}/${ahora.year}') {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.amber
            )
          );
        } if(fini.isBefore(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.red
            )
          );
        }
      } if(ahdos['metodo'] == 'En Desarrollo'){
        if(ffin.isAfter(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.green
            )
          );
        } if('${ffin.day}/${ffin.month}/${ffin.year}' == '${ahora.day}/${ahora.month}/${ahora.year}') {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.amber
            )
          );
        } if(ffin.isBefore(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.red
            )
          );
        }
      } if(ahdos['metodo'] == 'Terminado'){
        if(ffin.isAfter(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.green
            )
          );
        } if('${ffin.day}/${ffin.month}/${ffin.year}' == '${ahora.day}/${ahora.month}/${ahora.year}') {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.amber
            )
          );
        } if(ffin.isBefore(ahora)) {
          return Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.red
            )
          );
        }
      } return Container(
        width: 10,
        decoration: BoxDecoration(
          color: Colors.black
        )
      );
    }),
    
    /////////////Card Actividad Update /////////////////
      
    onTap: (){
      showDialog<dynamic>(
        context: context,
        builder: (context)=>
        Dialog(
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const SizedBox(height: 10),
                      const Text('Actividad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: actividad = ahdos["nombre"],
                        validator: (value) =>
                        value!.isEmpty ? "Campo requerido" : null,
                        onChanged: (String value) {
                          actividad = value;
                        },
                        decoration: const InputDecoration(
                          filled: true, 
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Actividad',
                        ),
                      ),
                      const SizedBox(height: 15),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                        .collection('Proyecto')
                        .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (!streamSnapshot.hasData) {
                            return Center( child: CircularProgressIndicator());
                          }

                          Timestamp i = widget.ahuno['f_inicio'];
                          Timestamp f = widget.ahuno['f_fin'];
                          DateTime bi = i.toDate();
                          DateTime bf = f.toDate();
                          
                          Timestamp ii = ahdos['f_inicio'];
                          Timestamp ff = ahdos['f_fin'];
                          DateTime bbi = ii.toDate();
                          DateTime bbf = ff.toDate();
                          
                          actini = bbi;
                          actfin = bbf;
                          metodo = ahdos['metodo'];
                          
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text('Fecha inicio',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  )),
                                  const SizedBox(width: 60),
                                  Text('Fecha fin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  )),
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
                                          initialDate: bi,
                                          firstDate: bi,
                                          lastDate: bf,
                                        );
                                        if (nuevo == null) return;
                                        setState(() {
                                          actini = nuevo;
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
                                          hintText: '${bbi.day}/${bbi.month}/${bbi.year}',
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
                                          initialDate: actini,
                                          firstDate: actini,
                                          lastDate: bf,
                                        );
                                        if (nuevo == null) return;
                                        setState(() {
                                          actfin = nuevo;
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
                                          hintText: '${bbf.day}/${bbf.month}/${bbf.year}',
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
                      const SizedBox(height: 15),
                      const Text('Estado',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15),
                      ),
                      const SizedBox(height: 10), 
                      Row(
                        children: [
                          Flexible(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                if (value == 'Por Hacer'){
                                  setState(() {
                                    metodo = value!;
                                  });
                                } if (value == 'En Desarrollo'){
                                  setState(() {
                                    metodo = value!;
                                  });
                                } if (value == 'Terminado'){
                                  setState(() {
                                    metodo = value!;
                                  });
                                }
                              },
                              validator: (item) {
                                if (item == null) {
                                  return "Campo requerido";
                                } else {
                                  return null;
                                }
                              },
                              hint: Text(
                                ahdos["metodo"],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            streamSnapshot.data!.docs[index].reference.update({
                            'nombre': actividad,
                            'metodo': metodo,
                            'f_inicio': actini,
                            'f_fin': actfin,
                            }).whenComplete(() => Navigator.pop(context));
                          },
                          child: const Text("Actualizar",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ), 
                      ),
                      const SizedBox(height: 20), 
                    ],
                  ),
                ] 
              ),
            ),
          )
        )
      );
    },
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        flex: 10,
        child: Container(
          height: 25,
          child:Center(
            child: Text(ahdos["metodo"],
            style:const TextStyle(fontSize: 15, color: Colors.white 
            )),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(4)
            ),
            color: Color.fromARGB(255, 95, 127, 153),
          ),
        )
      ),
    ],
  ),
  ],
  ),
  ),
  ),
  );
  }); 
  })),
  ),
  ); 
                       
} ),
  floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.of(context).push(MaterialPageRoute( 
        builder: (context) => act_add(actadd: widget.ahuno))
        );
        },
        backgroundColor: Color.fromARGB(255, 95, 127, 153),
        child: const Icon(Icons.add),
        elevation: 2,
  )
  );
}