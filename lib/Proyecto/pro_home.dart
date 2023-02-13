// ignore_for_file: camel_case_types, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/Actividad/act_home.dart';
import 'package:app_flutter/Proyecto/pro_add.dart';
import 'package:app_flutter/Autentication/login.dart';

class pro_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _pro_home(),
    );
  }
}
class _pro_home extends StatefulWidget {
  @override
  State<_pro_home> createState() => prohome();
}
class prohome extends State<_pro_home> {
  CollectionReference ref = FirebaseFirestore.instance
  .collection('Proyecto');
  String name = '';
   bool searchState= false;
 
  @override
  Widget build(BuildContext context) => 
  Scaffold(
    appBar: AppBar(
        centerTitle: true,
        title: !searchState?Text('ALFAPRO'):Card(
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), 
                hintText: 'Search'),
                onChanged:(val){
                  setState((){
                    name = val;
                  }
                  );
                }
              )
            ),
              backgroundColor: const Color(0xff26282c),
               actions: <Widget>[
          !searchState?IconButton(icon: const Icon(Icons.search),
          color: Colors.grey,
          onPressed: () {
          setState(() {
            searchState = !searchState;
          });
          }
          ):
          IconButton(icon: const Icon(Icons.cancel),
          color: Colors.grey,
          onPressed: () {
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => pro_home()));
          }
          
          ),
           IconButton(icon: const Icon(Icons.logout,),
          color: Colors.grey,
          
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) => print("Signed Out"));
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()));
          }
          ),
        
        ],
        
         ),
    backgroundColor: Color(0x222222),
    body: FutureBuilder<QuerySnapshot>(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.docs.length == 0) {
            return Center(
              child: Text(
                "No tienes proyectos registrados",
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('Proyecto')
                  .orderBy('nombre')
                  .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState==ConnectionState.waiting)?
                  Center(
                    child: CircularProgressIndicator(),)
                    :ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot prodata = snapshot.data!.docs[index];
                        Timestamp i = prodata['f_inicio'];
                        Timestamp f = prodata['f_fin'];
                        DateTime di = i.toDate();
                        DateTime df = f.toDate();
                        if (name.isEmpty){
                        return  Padding(
                          padding: const EdgeInsets.all(5.0),
                            child:Card(
                              child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                           ListTile(
                            title:Text(prodata["nombre"],
                            style:const TextStyle(fontSize: 18, color: Colors.black
                            ),
                            ),
                             subtitle: Row(
                              children: [
                          Icon(
                           Icons.person, 
                             size: 18,),
                              const SizedBox(width: 5, height: 40),
                             Text(prodata["cliente"],
                             style:const TextStyle(fontSize: 15, color: Colors.black
                              ),
                            ),
                          ],
                         ),
                                   onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=> act_home(ah:prodata)
                                    ),
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
                                          child: Text('${di.day}/${di.month}/${di.year}   -   ${df.day}/${df.month}/${df.year}',
                                          style: const TextStyle(fontSize: 15, color: Colors.white
                                          ),
                                        ),
                                        ),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4)),
                                              color:  Color.fromARGB(255, 95, 127, 153)
                                               ),
                                             )
                                            )
                                          ],
                                        ),
                              
                                   ],
                              
                                 ),
                                 
                                ),
                                
                              );
                        }
                        if (prodata['nombre'].toString().contains(name)){
                          return   Padding(
                          padding: const EdgeInsets.all(5.0),
                            child:Card(
                              child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                           ListTile(
                            title:Text(prodata["nombre"],
                            style:const TextStyle(fontSize: 18, color: Colors.black
                            ),
                            ),
                             subtitle: Row(
                              children: [
                          Icon(
                           Icons.person, 
                             size: 18,),
                              const SizedBox(width: 5, height: 40),
                             Text(prodata["cliente"],
                             style:const TextStyle(fontSize: 15, color: Colors.black
                              ),
                            ),
                          ],
                         ),
                                   onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=> act_home(ah:prodata)
                                    ),
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
                                          child: Text('${di.day}/${di.month}/${di.year}   -   ${df.day}/${df.month}/${df.year}',
                                          style: const TextStyle(fontSize: 15, color: Colors.white
                                          ),
                                        ),
                                        ),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4)),
                                              color:  Color.fromARGB(255, 95, 127, 153)
                                               ),
                                             )
                                            )
                                          ],
                                        ),
                              
                                   ],
                              
                                 ),
                                 
                                ),
                                
                              );
              }
              return Container();
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
        builder: (context) => pro_add(),)
        );
        },
        backgroundColor: Color.fromARGB(255, 95, 127, 153),
        child: const Icon(Icons.add),
        elevation: 2,
      ),

      );
}