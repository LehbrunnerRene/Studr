import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/google_sign_in.dart';
import 'package:studr/widgets/auth.dart';

import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        color: new Color(0xff00d5ff),
                        gradient: LinearGradient(
                          colors: [
                            (new Color(0xff00d5ff)),
                            new Color(0xff00d5ff)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1.5,
                            offset: Offset(5, 10),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, right: 150),
                            child: Image.asset(
                              "assets/logo/Studr.png",
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ],
                      )),
                    ),

                    /*Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90)),
                        color: new Color(0xff00d5ff),
                        gradient: LinearGradient(
                          colors: [
                            (new Color(0xff00d5ff)),
                            new Color(0xff00d5ff)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Image.asset(
                              "assets/logo/Studr.png",
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ],
                      )),
                    ),*/
                  ),
                  Flexible(
                    flex: 2,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'firstname': '',
    'lastname': '',
    'birthdate': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  DateTime _date = DateTime.now();

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
        print(
          _date.toString(),
        );
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ein Fehler ist aufgetreten'),
        content: Text(message),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OKAY'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
          _authData['firstname'],
          _authData['lastname'],
          _authData['birthdate'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    /*setState(() {
      _isLoading = false;
    });*/
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: TextFormField(
                cursorColor: Color(0xff00d5ff),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Color(0xff00d5ff),
                  ),
                  hintText: "E-mail",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Bitte E-mail eingeben!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
            ),
            if (_authMode == AuthMode.Signup)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: TextFormField(
                  cursorColor: Color(0xff00d5ff),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xff00d5ff),
                    ),
                    hintText: "Vorname",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Falsche Eingabe';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['firstname'] = value;
                    print(value);
                  },
                ),
              ),
            if (_authMode == AuthMode.Signup)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: TextFormField(
                  cursorColor: Color(0xff00d5ff),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xff00d5ff),
                    ),
                    hintText: "Nachname",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Falsche Eingabe';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['lastname'] = value;
                    print(value);
                  },
                ),
              ),
            if (_authMode == AuthMode.Signup)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: TextFormField(
                  cursorColor: Color(0xff00d5ff),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.celebration_sharp,
                      color: Color(0xff00d5ff),
                    ),
                    hintText: "Geburtsdatum",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  key: Key(_date.toString()),
                  initialValue:
                      ("${_date.day.toString()}.${_date.month.toString()}.${_date.year.toString()}"),
                  validator: (value) {
                    print(_authData["birthdate"]);
                    if (value.isEmpty) {
                      return 'Falsche Eingabe';
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      _selectDate(context);
                    });
                  },
                  onSaved: (value) {
                    _authData['birthdate'] = value;
                    print(value);
                  },
                ),
              ),

            /*TextFormField(
                decoration: InputDecoration(labelText: 'Geburtsdatum'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Falsche Eingabe';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['birthdate'] = value;
                  print(value);
                },
              ),*/
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: TextFormField(
                cursorColor: Color(0xff00d5ff),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Color(0xff00d5ff),
                  ),
                  hintText: "Passwort",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Passwort ist zu kurz';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
            ),
            if (_authMode == AuthMode.Signup)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: TextFormField(
                  cursorColor: Color(0xff00d5ff),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                      color: Color(0xff00d5ff),
                    ),
                    hintText: "Passwort wiederholen",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  enabled: _authMode == AuthMode.Signup,
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwörter stimmen nicht überein';
                          }
                        }
                      : null,
                ),
              ),
            SizedBox(
              height: 20,
            ),
            if (_isLoading)
              CircularProgressIndicator(
                color: Color(0xff00d5ff),
              )
            else
              ElevatedButton(
                child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    primary: Color(0xff00d5ff),
                    onPrimary: Colors.white,
                    enableFeedback: true,
                    textStyle: TextStyle(fontSize: 16),
                    minimumSize: Size(deviceSize.width * 0.5, 40)),
              ),
            FlatButton(
              child: Text(
                  '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
              onPressed: _switchAuthMode,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
              //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Color(0xff00d5ff),
            ),
            if (_authMode == AuthMode.Login)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Color(0xff00d5ff),
                    onPrimary: Colors.white,
                    minimumSize: Size(deviceSize.width * 0.9, 50)),
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue),
                label: Text("Sign Up with Google"),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
              ),
          ],
        ),
      ),
    );
  }
}
