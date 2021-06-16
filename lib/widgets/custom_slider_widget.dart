import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSliderWidget extends StatefulWidget {
  final dynamic selectedItem;
  final dynamic selectedDate;
  
  CustomSliderWidget(this.selectedItem, this.selectedDate);
  @override
  _CustomSliderWidget createState() => _CustomSliderWidget();
}

class _CustomSliderWidget extends State<CustomSliderWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _maxWidth = 0.0;
  var _width = 0.0;
  var _value = 0.0;
  var _booked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contrainst) {
        _maxWidth = contrainst.maxWidth;
        return Container(
            height: 60,
            decoration: BoxDecoration(
              color: _booked ? Colors.greenAccent : Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              border: Border.all(
                color: _booked ? Colors.greenAccent : Colors.blue,
                width: 3,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    _booked ? "Termin gebucht" : "Buchen",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: _width <= 57 ? 57 : _width,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onVerticalDragUpdate: _onDrag,
                        onVerticalDragEnd: _onEnd,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Icon(Icons.keyboard_arrow_right,
                              color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  void _onDrag(DragUpdateDetails details) {
    setState(() {
      _value = (details.globalPosition.dx) / _maxWidth;
      _width = _maxWidth * _value;
    });
  }

  void _onEnd(DragEndDetails details) {
    if(_value > 0.9){
      _value = 1;

      FirebaseFirestore.instance
        .collection("Booking")
        .add(
      {
        'name': widget.selectedItem["title"],
        'date': widget.selectedDate
      },
    );
    } else{
      _value = 0;
    }

    setState(() {
      _width = _maxWidth * _value;
      _booked = _value > 0.9;
    });
  }
}
