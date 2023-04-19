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
final TextEditingController emailController = TextEditingController();
final TextEditingController posController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _NewPageState extends State<NewPage> {
  final firestore =
      FirebaseFirestore.instance.collection('gdscTeam').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('gdscTeam');
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Add new Email"),
                                        controller: emailController,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Add new Position"),
                                        controller: posController,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Add Name"),
                                        controller: nameController,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          //Position
                                          ref
                                              .doc(snapshot
                                                  .data!.docs[index]['id']
                                                  .toString())
                                              .update({
                                            'position':
                                                posController.text.toString()
                                          }).then((value) => print("updated"));
                                          //Name
                                          ref
                                              .doc(snapshot
                                                  .data!.docs[index]['id']
                                                  .toString())
                                              .update({
                                            'name':
                                                nameController.text.toString()
                                          }).then((value) => print("updated"));
                                          //email
                                          ref
                                              .doc(snapshot
                                                  .data!.docs[index]['id']
                                                  .toString())
                                              .update({
                                            'email':
                                                emailController.text.toString()
                                          }).then((value) => print("updated"));
                                        },
                                        child: Text("Update Now"),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .delete()
                                .then((value) => print("Sucessfully Deleted"));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                  title: Text(
                    snapshot.data!.docs[index]['name'].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Position :' +
                          snapshot.data!.docs[index]['position'].toString()),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Email :' +
                          snapshot.data!.docs[index]['email']
                              .toString()
                              .trim()),
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}
