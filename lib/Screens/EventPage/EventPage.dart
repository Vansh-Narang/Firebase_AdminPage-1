import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/EventPage/EventScheduler.dart';

// import 'EventScheduler.dart';
class SavedDataPage extends StatefulWidget {
  const SavedDataPage({Key? key}) : super(key: key);

  @override
  _SavedDataPageState createState() => _SavedDataPageState();
}

class _SavedDataPageState extends State<SavedDataPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _status = '';
  String _imageUrl = '';

  String imageUrl = '';
  String title = '';
  String _completeTitle = '';
  DateTime? _date;
  TimeOfDay? _time;
  TimeOfDay? _startTime;
  TimeOfDay? _finishTime;
// String venue = '';
  // String status = '';
  String _type = '';
  String _description = '';
  String _speakerName = '';
  String _speakerType = '';
  String _speakerImageurl = '';
  String _eventImage1 = '';
  String _eventImage2 = '';
  String _eventImage3 = '';
  String _eventImage4 = '';

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
                          String imageUrl = '';
                          String title = '';
                          String completeTitle = '';
                          DateTime? date;
                          TimeOfDay? time;
                          TimeOfDay? startTime;
                          TimeOfDay? finishTime;
// String venue = '';
                          String status = '';
                          String type = '';
                          String description = '';
                          String speakerName = '';
                          String speakerType = '';
                          String speakerImageurl = '';
                          String eventImage1 = '';
                          String eventImage2 = '';
                          String eventImage3 = '';
                          String eventImage4 = '';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Item'),
                                content: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: _title,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Title',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Title is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _title = value!;
                                          },
                                        ),
                                        TextFormField(
                                          initialValue: _completeTitle,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Complete title',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Complete title is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _status = value!;
                                          },
                                        ),
                                        // TextFormField(
                                        //   initialValue: _date,
                                        //   decoration: InputDecoration(
                                        //     hintText: 'Enter Status',
                                        //   ),
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Status is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   onSaved: (value) {
                                        //     _status = value!;
                                        //   },
                                        // ),
                                        // TextFormField(
                                        //   initialValue: _type,
                                        //   decoration: InputDecoration(
                                        //     hintText: 'Enter Event Type',
                                        //   ),
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Event Type is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   onSaved: (value) {
                                        //     _status = value!;
                                        //   },
                                        // ),
                                        TextFormField(
                                          initialValue: _description,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Description',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Descriptiom is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _status = value!;
                                          },
                                        ),
                                        TextFormField(
                                          initialValue: _speakerName,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Speaker Name',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Speaker Name is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _status = value!;
                                          },
                                        ),
                                        // TextFormField(
                                        //   initialValue: _status,
                                        //   decoration: InputDecoration(
                                        //     hintText: 'Enter Status',
                                        //   ),
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Status is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   onSaved: (value) {
                                        //     _status = value!;
                                        //   },
                                        // ),
                                        // TextFormField(
                                        //   initialValue: _status,
                                        //   decoration: InputDecoration(
                                        //     hintText: 'Enter Status',
                                        //   ),
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Status is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   onSaved: (value) {
                                        //     _status = value!;
                                        //   },
                                        // ),
                                        // TextFormField(
                                        //   initialValue: _imageUrl,
                                        //   decoration: InputDecoration(
                                        //     hintText: 'Enter Image URL',
                                        //   ),
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Image URL is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   onSaved: (value) {
                                        //     _imageUrl = value!;
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Save'),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        // Update
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(document.id)
                                            .update({
                                          'imageUrl': _imageUrl,
                                          'title': _title,
                                          'completeTitle': _completeTitle,
                                          'date': _date,
                                          'startTime': _startTime,
                                          'finishTime': _finishTime,
                                          // 'venue': venue,
                                          'status': _status,
                                          'type': _type,
                                          'description': _description,
                                          'speakerName': _speakerName,
                                          'speakerType': _speakerType,
                                          'SpeakerImageurl': _speakerImageurl
                                        }).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Item edited successfully')),
                                          );
                                          Navigator.pop(context);
                                        }).catchError((error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Failed to edit item')),
                                          );
                                        });
                                      }
                                    },
                                  ),
                                ],
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
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Item deleted successfully')),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete item')),
                            );
                          });
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
}
