import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirestoreListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore ListView Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('myCollection').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data();
              final title = 'title';
              final imageUrl = 'imageUrl';
              return ListTile(
                leading: Image.network(imageUrl),
                title: Text(title),
              );
            },
          );
        },
      ),
    );
  }
}
