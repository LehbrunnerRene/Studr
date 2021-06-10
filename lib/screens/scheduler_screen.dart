import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';
import 'package:studr/widgets/custom_slider_widget.dart';

class SchedulerScreen extends StatefulWidget {
  final dynamic selectedItem;

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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          //loadImage(context),
          buttonClose(context),
          openingBar(),
          loadImageNew(deviceSize),
          Container(
            
            
            ),
          


        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .15,
          right: MediaQuery.of(context).size.width * .15,
          bottom: 12,
        ),
        child: CustomSliderWidget(),
      ),
    );

    /*return Card(
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
                  'assets/icons/${widget.selectedItem["icon"]}',
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
    );*/
  }

  Container loadImageNew(Size deviceSize) {
    return Container(
          height: 260,
          width: deviceSize.width * 0.90,
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/icons/${widget.selectedItem["icon"]}',
                    fit: BoxFit.cover,
                    height: deviceSize.height * 0.27,
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Container loadImage(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .6,
        child: PageView.builder(
          itemBuilder: (context, index) {
            return Image.asset(
              'assets/icons/${widget.selectedItem["icon"]}',
              fit: BoxFit.cover,
            );
          },
        ));
  }

  Align buttonClose(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 24, top: 45),
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Container openingBar() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 50),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.lock_clock,
            size: 30,
            color: Colors.green,
          ),
          Text(
            "Jetzt geöffnet",
            style: TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
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
