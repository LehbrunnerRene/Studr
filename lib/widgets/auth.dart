import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, bool signUp,
      [String username]) async {
    UserCredential uC;
    try {
      if (signUp) {
        uC = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        uC = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }

      /*_token = uC['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );*/
      await FirebaseAuth.instance.currentUser.updateDisplayName(username);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({'username': username, 'email': email});
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String username) async {
    return _authenticate(email, password, true, username);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, false);
  }
}
