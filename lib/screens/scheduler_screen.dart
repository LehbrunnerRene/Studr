import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';

class SchedulerScreen extends StatefulWidget {
  final Hairdresser selectedItem;

  SchedulerScreen(this.selectedItem);
  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: 260,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/icons/${widget.selectedItem.icon}',
                  fit: BoxFit.cover,
                  height: deviceSize.height * 0.25,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date'),
                  controller: txt,
                  onSaved: (value) {},
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final selectedDate = await _selectDateTime(context);
                    if (selectedDate == null) return;

                    print(selectedDate);

                    final selectedTime = await _selectTime(context);
                    if (selectedTime == null) return;
                    print(selectedTime);

                    setState(() {
                      this.selectedDate = DateTime(
                        selectedDate.day,
                        selectedDate.month,
                        selectedDate.year,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                      txt.text = dateFormat.format(selectedDate);
                    });
                  },
                  label: Text("Date"),
                ),
                SizedBox(
                  height: 150,
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: ElevatedButton.icon(
                    label: Text('Termin Buchen'),
                    icon: Icon(Icons.book_online),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: Colors.yellow,
                        textStyle: TextStyle(fontSize: 24),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.all(20)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<TimeOfDay> _selectTime(BuildContext context) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
  );
}

Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
