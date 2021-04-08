import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserHelper extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Map<String, dynamic> _userData = Map();
  bool isLoading = false;

 static UserHelper of(BuildContext context) => ScopedModel.of<UserHelper>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
     recoverUserData();
  }

  void signUp(
      {@required Map<String, dynamic> dataUser,
      @required String password,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    print('1 ${dataUser['email']}');
    _auth
        .createUserWithEmailAndPassword(
            email: dataUser['email'], password: password)
        .then((value) async {
      _user = value;
      print('2 ${value}');
      await _saveUserData(dataUser);
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signOut() async {
    await _auth.signOut();
    _userData = Map();
    _user = null;
    notifyListeners();
  }

  void signIn(
      {@required String email,
      @required String senha,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    print('email ${email} senha $senha');
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((usuario) async {
      _user = usuario;
      await recoverUserData();
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPassword(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Null> recoverUserData() async {
    if (_user == null) {
      _user = await _auth.currentUser();
    }
    if (_user != null) {
      if (_userData['nome'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection('users')
            .document(_user.uid)
            .get();
        _userData = docUser.data;
      }
    }
    notifyListeners();
  }

  bool isLoggedIn() {
    return _user != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> data) async {
    this._userData = data;
    await Firestore.instance
        .collection('users')
        .document(_user.uid)
        .setData(data);
  }

  FirebaseUser get user {
    return _user;
  }

  Map<String, dynamic> get userData {
    return _userData;
  }
}
