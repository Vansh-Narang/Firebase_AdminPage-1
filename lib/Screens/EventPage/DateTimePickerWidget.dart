import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimePickerWidget extends StatefulWidget {
  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  late DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTimeField(
          format: DateFormat("yyyy-MM-dd HH:mm"),
          decoration: InputDecoration(
            labelText: 'Select date and time',
            border: OutlineInputBorder(),
          ),
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final time = awaitshowTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              selectedDateTime = DateTimeField.combine(date, time);
              return selectedDateTime;
            } else {
              return currentValue;
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('testing_name')
                .add({'selected_date_time': selectedDateTime});
          },
          child: Text('Save to Firebase'),
        ),
      ],
    );
  }
}
