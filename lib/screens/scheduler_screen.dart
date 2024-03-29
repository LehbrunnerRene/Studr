import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  DateTime selectedTime = DateTime.now();

  var txt = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  DateTime _date = DateTime.now();
  String _selectedTime;
  String _selectedHairdresser;
  var _btnPressed = List<bool>.filled(16, false);
  var _hairdresserPressed = List<bool>.filled(4, false);

  Future<Null> _selectDate(BuildContext context) async {
    var categoryHeight = MediaQuery.of(context).size;
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              accentColor: Colors.blue,
            ),
            child: child,
          );
        });

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        print(widget.selectedItem);
        print(_selectedTime);
        print(
          _date.toString(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          //loadImage(context),
          buttonClose(context),
          loadImageNew(deviceSize),
          //openingBar(),
          //Title(),
          dateTitle(),
          datePicker(),
          workersTitle(),
          workers(),
          timesTitle(),
          timeSlots()
          //timePicker(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .15,
          right: MediaQuery.of(context).size.width * .15,
          bottom: 12,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black)),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("bookings")
                .add(<String, dynamic>{
              "date": _date,
              "time": _selectedTime,
              "hairdresser": _selectedHairdresser,
              "username": FirebaseAuth.instance.currentUser.displayName,
              "userId": FirebaseAuth.instance.currentUser.uid,
              "HairdresserCompanyId": widget.selectedItem["id"]
            });
            Navigator.pop(context);
            /*CupertinoAlertDialog(
              title: Text("Buchung erfolgreich"),
              content: Icon(
                Icons.done,
                color: Colors.green,
              ),
            );*/
          },
          child: const Text(
            "Buchen",
            style: TextStyle(fontSize: 18),
          ),
        ),
        //CustomSliderWidget(widget.selectedItem, selectedDate, selectedTime),
      ),
    );
  }

  Container dateTitle() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .27,
          left: MediaQuery.of(context).size.width * .05),
      child: Text(
        "Datum wählen",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container datePicker() {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * .05,
          top: MediaQuery.of(context).size.height * .32,
          left: MediaQuery.of(context).size.width * .05),
      child: TextFormField(
        cursorColor: Colors.blue,
        readOnly: true,
        onTap: () {
          setState(() {
            _selectDate(context);
          });
        },
        decoration: InputDecoration(
          //labelText: 'Select Date',
          //labelStyle: TextStyle(fontSize: 16.0, color: Colors.blue),
          hintText: (_date.toString().replaceRange(10, 23, '')),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }

  Container workersTitle() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .42,
          left: MediaQuery.of(context).size.width * .05),
      child: Text(
        "Mitarbeiter wählen",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container workers() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .47,
          left: MediaQuery.of(context).size.width * .05),
      child: Row(
        children: [
          Column(
            children: [
              Material(
                elevation: 4.0,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  colorFilter: _hairdresserPressed[0]
                      ? ColorFilter.mode(Colors.grey, BlendMode.color)
                      : null,
                  image: AssetImage('assets/workers/worker1.jpg'),
                  fit: BoxFit.cover,
                  width: 75.0,
                  height: 75.0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedHairdresser = "Martina";
                        _hairdresserPressed.fillRange(0, 3, false);
                        _hairdresserPressed[0] = !_hairdresserPressed[0];
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Martina",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            children: [
              Material(
                elevation: 4.0,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  colorFilter: _hairdresserPressed[1]
                      ? ColorFilter.mode(Colors.grey, BlendMode.color)
                      : null,
                  image: AssetImage('assets/workers/worker5.jpg'),
                  fit: BoxFit.cover,
                  width: 75.0,
                  height: 75.0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedHairdresser = "Laura";
                        _hairdresserPressed.fillRange(0, 3, false);
                        _hairdresserPressed[1] = !_hairdresserPressed[1];
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Laura",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            children: [
              Material(
                elevation: 4.0,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  colorFilter: _hairdresserPressed[2]
                      ? ColorFilter.mode(Colors.grey, BlendMode.color)
                      : null,
                  image: AssetImage('assets/workers/worker3.jpg'),
                  fit: BoxFit.cover,
                  width: 75.0,
                  height: 75.0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedHairdresser = "Sarah";
                        _hairdresserPressed.fillRange(0, 3, false);
                        _hairdresserPressed[2] = !_hairdresserPressed[2];
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Sarah",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            children: [
              Material(
                elevation: 4.0,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  colorFilter: _hairdresserPressed[3]
                      ? ColorFilter.mode(Colors.grey, BlendMode.color)
                      : null,
                  image: AssetImage('assets/workers/worker4.jpg'),
                  fit: BoxFit.cover,
                  width: 75.0,
                  height: 75.0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedHairdresser = "Mario";
                        _hairdresserPressed.fillRange(0, 3, false);
                        _hairdresserPressed[3] = !_hairdresserPressed[3];
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Mario",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container timesTitle() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .65,
          left: MediaQuery.of(context).size.width * .05),
      child: Text(
        "Zeit wählen",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container timeSlots() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .7,
          left: MediaQuery.of(context).size.width * .05),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[0]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  print("test");
                  _selectedTime = "9";
                  setState(() {
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[0] = !_btnPressed[0];
                  });
                },
                child: const Text(
                  "9:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[1]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "9:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[1] = !_btnPressed[1];
                  });
                },
                child: const Text(
                  "9:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[2]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "10:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[2] = !_btnPressed[2];
                  });
                },
                child: const Text(
                  "10:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[3]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "10:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[3] = !_btnPressed[3];
                  });
                },
                child: const Text(
                  "10:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[4]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "11:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[4] = !_btnPressed[4];
                  });
                },
                child: const Text(
                  "11:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[5]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "11:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[5] = !_btnPressed[5];
                  });
                },
                child: const Text(
                  "11:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[6]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "12:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[6] = !_btnPressed[6];
                  });
                },
                child: const Text(
                  "12:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[7]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "12:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[7] = !_btnPressed[7];
                  });
                },
                child: const Text(
                  "12:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[8]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "13:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[8] = !_btnPressed[8];
                  });
                },
                child: const Text(
                  "13:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[15]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "13:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[15] = !_btnPressed[15];
                  });
                },
                child: const Text(
                  "13:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[9]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "14:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[9] = !_btnPressed[9];
                  });
                },
                child: const Text(
                  "14:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[10]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "14:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[10] = !_btnPressed[10];
                  });
                },
                child: const Text(
                  "14:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[11]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "15:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[11] = !_btnPressed[11];
                  });
                },
                child: const Text(
                  "15:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[12]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "15:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[12] = !_btnPressed[12];
                  });
                },
                child: const Text(
                  "15:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[13]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "16:00";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[13] = !_btnPressed[13];
                  });
                },
                child: const Text(
                  "16:00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 77,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: _btnPressed[14]
                        ? MaterialStateProperty.all(Colors.grey)
                        : MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _selectedTime = "16:30";
                    _btnPressed.fillRange(0, 16, false);
                    _btnPressed[14] = !_btnPressed[14];
                  });
                },
                child: const Text(
                  "16:30",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Padding timePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 380),
      child: SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          initialDateTime: selectedDate,
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          onDateTimeChanged: (selectedTime) =>
              setState(() => this.selectedTime = selectedTime),
        ),
      ),
    );
  }

  /*Row datePicker(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 600,
          width: 85,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${dateFormat.format(selectedDate)}",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonTheme(
              minWidth: 40,
              height: 40,
              child: RaisedButton(
                onPressed: () => _selectDate(context), // Refer step 3
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: Colors.greenAccent,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0))),
            ),
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }*/

  Container Title() {
    return Container(
        margin: EdgeInsets.only(top: 260, left: 40),
        child: Column(
          children: <Widget>[
            Text(
              "Termin wählen:",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Container loadImageNew(Size deviceSize) {
    return Container(
      height: 260,
      width: deviceSize.width * 0.97,
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/icons/${widget.selectedItem["icon"]}',
                fit: BoxFit.cover,
                height: deviceSize.height * 0.24,
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
        margin: EdgeInsets.only(right: 2, top: 45),
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
      margin: EdgeInsets.only(left: 24, top: 250),
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

  /*_selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }*/
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
