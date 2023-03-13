import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SavedDataPage extends StatelessWidget {
  const SavedDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return ListTile(
                title: Text(data['completeTitle']),
                // subtitle: Text(data['date'].toDate().toString()),
                trailing: Text(data['status']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
