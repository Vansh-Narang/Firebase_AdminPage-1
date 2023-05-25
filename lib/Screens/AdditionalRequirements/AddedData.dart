import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddedData extends StatefulWidget {
  const AddedData({super.key});

  @override
  State<AddedData> createState() => _AddedData();
}

final firestore =
    FirebaseFirestore.instance.collection('collabFootfalls').snapshots();
CollectionReference ref =
    FirebaseFirestore.instance.collection('collabFootfalls');

class _AddedData extends State<AddedData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Added Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('collabFootfalls')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Collabs :' +
                            snapshot.data!.docs[index]['Collabs'].toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300)),
                    Text(
                        'Events :' +
                            snapshot.data!.docs[index]['Events'].toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300)),
                    Text(
                        'Footfalls :' +
                            snapshot.data!.docs[index]['Footfalls'].toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300)),
                    Text(
                        'Prizes :' +
                            snapshot.data!.docs[index]['Prizes'].toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300)),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
