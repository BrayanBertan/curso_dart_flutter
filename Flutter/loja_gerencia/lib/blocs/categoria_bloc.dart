import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();

  final _imageController = BehaviorSubject();

  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outCategoria => _titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.trim().isEmpty) {
          return sink.addError('Insira um titulo');
        } else {
          sink.add(title);
        }
      }));

  Stream<bool> get SubmmitedValue =>
      Observable.combineLatest2(outCategoria, outImage, (a, b) => true);

  Stream get outImage => _imageController.stream;

  Stream<bool> get outDelete => _deleteController.stream;

  File image;
  String title;

  DocumentSnapshot categoria;
  CategoriaBloc(this.categoria) {
    if (categoria != null) {
      title = categoria.data['titulo'];
      _titleController.add(categoria.data['titulo']);
      _imageController.add(categoria.data['url']);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(File file) {
    image = file;
    _imageController.add(file);
  }

  void setTitulo(String titulo) {
    title = titulo;
    _titleController.add(titulo);
  }

  Future saveCategoria() async {
    if (image == null && categoria != null && title == categoria.data['titulo'])
      return;

    Map<String, dynamic> dataToUpdate = {};

    if (image != null) {
      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('icons')
          .child(title)
          .putFile(image);
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;

      dataToUpdate['url'] = await snapshot.ref.getDownloadURL();
    }
    if (categoria != null || title != categoria.data['titulo']) {
      dataToUpdate['titulo'] = title;
    }

    if (categoria == null) {
      await Firestore.instance
          .collection(title.toLowerCase())
          .add(dataToUpdate);
    } else {
      await categoria.reference.updateData(dataToUpdate);
    }
  }

  void delete() {
    categoria.reference.delete();
  }

  @override
  void dispose() {
    _titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}
