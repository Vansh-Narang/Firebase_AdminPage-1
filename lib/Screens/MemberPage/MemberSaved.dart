import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Login_Admin/Login.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

//Read data
class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members Detail"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('gdscTeam').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                title: Text(document['name']),
                // subtitle: Text(document['id']),
                // leading: Image.network(document['imageUrl']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// // update the memeber data
// UpdateMember() {
//   final updateuser =
//       FirebaseFirestore.instance.collection('gdscTeam').doc('');

//   updateuser.update({'name': 'hiiiiiiiiiiiiiiii'});
// }
// //delete data
// DeleteMember()
// {
//   final deleteuser=FirebaseFirestore.instance
//   .collection('users')
//   .doc()

// deleteuser.delete();
// }