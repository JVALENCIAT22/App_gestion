// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class team_info extends StatefulWidget {
  @override
  _team_info createState() => _team_info();
}

class _team_info extends State<team_info> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('Proyecto')
        .where('participants', arrayContains: 'item'.isNotEmpty)
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      switch (streamSnapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
        default:
          if (streamSnapshot.hasError) {
            print(streamSnapshot.hasError.toString());
          } else {
            final channels = streamSnapshot.data!.docs;
            if (channels.isEmpty) {
              return Text('ff');
            } else{
              return ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(channels[i]['announceImage']),
                  ),
                  title: Text(channels[i]['reciverID']),
                ),
              );
            }
          }
      }
      return Text('ok');
    }
    );
  }
}