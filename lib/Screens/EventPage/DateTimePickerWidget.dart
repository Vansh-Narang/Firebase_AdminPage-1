import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampExample extends StatefulWidget {
  @override
  _TimestampExampleState createState() => _TimestampExampleState();
}

class _TimestampExampleState extends State<TimestampExample> {
  final TextEditingController dateController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  DateTime? pickDate;
  Timestamp? timestamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timestamp Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                keyboardType: TextInputType.none,
                controller: dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "Select Date",
                ),
                onTap: () async {
                  pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd-MM-yyyy').format(pickDate!);
                    });
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (pickDate != null) {
                  // Convert the DateTime value to a Timestamp object
                  timestamp = Timestamp.fromDate(pickDate!);

                  // Save the Timestamp to Firebase
                  await firestoreInstance.collection('myCollection').add({
                    'timestampField': timestamp,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Timestamp saved to Firebase')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a date')));
                }
              },
              child: Text('Save Timestamp to Firebase'),
            ),
            SizedBox(height: 32.0),
            // StreamBuilder<QuerySnapshot>(
            //   stream: firestoreInstance.collection('myCollection').snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     }

            //     // Retrieve the Timestamp data from Firebase
            //     Timestamp timestampData =
            //         snapshot.data!.docs.first['timestampField'];

            //     // Convert the Timestamp to a DateTime object
            //     DateTime dateTime = timestampData.toDate();

            //     return Text(
            //       'Timestamp from Firebase: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime)}',
            //       style: TextStyle(fontSize: 16.0),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
