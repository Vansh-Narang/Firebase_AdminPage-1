import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddedData.dart';

class CollabEvents extends StatefulWidget {
  const CollabEvents({super.key});

  @override
  State<CollabEvents> createState() => _CollabEventsState();
}

CollectionReference collabFootfalls =
    FirebaseFirestore.instance.collection('collabFootfalls');
String events = "";
String collabs = "";
String footfalls = "";
String prizes = "";

class _CollabEventsState extends State<CollabEvents> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController eventsController = TextEditingController();
  final TextEditingController collabsController = TextEditingController();
  final TextEditingController footfallsController = TextEditingController();
  final TextEditingController prizesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Footfalls And Collabs"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "No. of events"),
                  controller: eventsController,
                  validator: (value) =>
                      value!.isEmpty ? "The Events cannot be empty" : null,
                  onChanged: (value) {
                    setState(() {
                      events = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: "No. of Collaborations"),
                  controller: collabsController,
                  validator: (value) =>
                      value!.isEmpty ? "The Collabs cannot be empty" : null,
                  onChanged: (value) {
                    setState(() {
                      collabs = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: "No. of footfalls"),
                  controller: footfallsController,
                  validator: (value) =>
                      value!.isEmpty ? "The Footfalls cannot be empty" : null,
                  onChanged: (value) {
                    setState(() {
                      footfalls = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "No. of Prizes"),
                  controller: prizesController,
                  validator: (value) =>
                      value!.isEmpty ? "The Prizes cannot be empty" : null,
                  onChanged: (value) {
                    setState(() {
                      events = value;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddedData(),
                            ));
                      }
                    },
                    child: const Text("Add the Data")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addData() async {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  collabFootfalls
      .doc(id)
      .set({
        'id': id,
        'Events': events,
        'Collabs': collabs,
        'Footfalls': footfalls,
        'Prizes': prizes
      })
      .then((value) => print("Data Added"))
      .catchError((error) => print("Failed to add Dara: $error"));
}
