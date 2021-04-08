import 'dart:ffi';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProdutoBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();
  String cid;
  DocumentSnapshot produto;

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Map<String, dynamic> unsavedData;

  ProdutoBloc(this.cid, this.produto) {
    if (produto != null) {
      unsavedData = Map.of(produto.data);
      unsavedData['url'] = List.of(produto.data['url']);
      unsavedData['sizes'] = List.of(produto.data['sizes']);

      _createdController.add(true);
    } else {
      _createdController.add(false);
      unsavedData = {
        'descricao': null,
        'preco': null,
        'sizes': [],
        'titulo': null,
        'url': []
      };
    }
    _dataController.add(unsavedData);
  }

  void saveTitle(String param) {
    unsavedData['titulo'] = param;
  }

  void saveDescricao(String param) {
    unsavedData['descricao'] = param;
  }

  void savePrice(String param) {
    unsavedData['preco'] = double.parse(param);
  }

  void saveImages(List param) {
    unsavedData['url'] = param;
  }

  void saveSizes(List param) {
    unsavedData['sizes'] = param;
  }

  Future<bool> saveProduto() async {
    _loadingController.add(true);
    try {
      if (produto != null) {
        await _uploadImagens(produto.documentID);
        await produto.reference.updateData(unsavedData);
      } else {
        DocumentReference documentReference = await Firestore.instance
            .collection('produtos')
            .document(cid)
            .collection('itens')
            .add(Map.from(unsavedData)..remove('url'));
        await _uploadImagens(documentReference.documentID);
        await documentReference.updateData(unsavedData);
      }
      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (error) {
      print(error);
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImagens(String pid) async {
    for (int i = 0; i < unsavedData['url'].length; i++) {
      if (unsavedData['url'][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(cid)
          .child(pid)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData['url'][i]);

      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      unsavedData['url'][i] = downloadUrl;
    }
  }

  void deleteProduto(){
    produto.reference.delete();
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }
}
