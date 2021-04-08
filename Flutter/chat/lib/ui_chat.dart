import 'dart:io';

import 'package:chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chat/chat_message.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignin = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  FirebaseUser _currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) return _currentUser;
    try {
      final GoogleSignInAccount googleSigninAccount =
          await googleSignin.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSigninAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _sendMessage({String texto, PickedFile foto}) async {
    final FirebaseUser user = await _getUser();
    if (user == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Não foi possivel fazer login tenta novamente!")));
    }
    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl,
      "time":Timestamp.now()
    };
    if (foto != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(File(foto.path));
      setState(() {
        isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data["url"] = url;

     setState(() {
       isLoading = false;
     });
    }

    if (texto != null) data["texto"] = texto;

    Firestore.instance.collection("mensagens").document().setData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              _currentUser != null ? _currentUser.displayName : "Chat Online",
            ),
            centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            _currentUser != null?
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    googleSignin.signOut();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Saiu!")));
                  },
                )
                :
                Container()
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("mensagens").orderBy("time").snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return CircularProgressIndicator(
                        strokeWidth: 8.0,
                      );
                    default:
                      List<DocumentSnapshot> msgs =
                          snapshot.data.documents.reversed.toList();
                      return ListView.builder(
                          padding: EdgeInsets.all(12.5),
                          itemCount: msgs.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return ChatMessage(
                                msgs[index].data,
                                msgs[index].data["uid"] == _currentUser?.uid);
                          });
                  }
                },
              ),
            ),
            isLoading?
                LinearProgressIndicator():
            TextComposer(_sendMessage),
          ],
        ));
  }
}
