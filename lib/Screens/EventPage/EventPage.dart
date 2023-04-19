import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/EventPage/EventScheduler.dart';
// import 'EventScheduler.dart';

class SavedDataPage extends StatelessWidget {
  const SavedDataPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController posController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController completeTitleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController finishTimeController = TextEditingController();
  // final TextEditingController venueController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController speakerController = TextEditingController();
  final TextEditingController speakerTypeController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posted Event'),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
            padding: const EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(data['completeTitle']),
                  // subtitle: Text(data['date'].toDate().toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
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
                                      decoration:
                                          InputDecoration(hintText: "Add Name"),
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
                                          'name': nameController.text.toString()
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
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(document.id)
                              .delete()
                              .then((value) => print("Document Deleted"))
                              .catchError((error) =>
                                  print("Failed to delete document: $error"));
                        },
                      ),
                    ],
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Image.network(
                      data['imageUrl'],
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
