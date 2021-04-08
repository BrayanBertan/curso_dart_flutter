import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/produto_bloc.dart';
import 'package:loja_gerencia/validators/produto.dart';
import 'package:loja_gerencia/widgets/add_produto_sizes.dart';
import 'package:loja_gerencia/widgets/images.dart';

class ProdutoPage extends StatefulWidget {
  final String cid;
  final DocumentSnapshot produto;
  ProdutoPage(this.cid, this.produto);
  @override
  _ProdutoPageState createState() => _ProdutoPageState(cid, produto);
}

class _ProdutoPageState extends State<ProdutoPage> with ProdutoValidator {
  String cid;
  DocumentSnapshot produto;
  ProdutoBloc _produtoBloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _ProdutoPageState(this.cid, this.produto)
      : _produtoBloc = ProdutoBloc(cid, produto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
            stream: _produtoBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(snapshot.data ? 'Editando' : 'Criando');
            }),
        centerTitle: true,
        actions: [
          StreamBuilder<bool>(
              stream: _produtoBloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
                return StreamBuilder<bool>(
                    initialData: false,
                    stream: _produtoBloc.outLoading,
                    builder: (context, snapshotLoading) {
                      return (snapshotLoading.data || !snapshot.data)
                          ? Container()
                          : IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: snapshot.data
                                  ? () {
                                      produto.reference.delete();
                                      Navigator.of(context).pop();
                                    }
                                  : null);
                    });
              }),
          StreamBuilder<bool>(
              stream: _produtoBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: snapshot.data
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Salvando produto...'),
                                duration: Duration(minutes: 1),
                              ));

                              bool success = await _produtoBloc.saveProduto();
                              _scaffoldKey.currentState.removeCurrentSnackBar();

                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(success ? 'Salvo' : 'erro'),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          });
              }),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
                stream: _produtoBloc.outData,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Container()
                      : ListView(
                          padding: EdgeInsets.all(16.0),
                          children: [
                            Text(
                              'Imagens',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            ImagesWidget(
                              context: context,
                              initialValue: snapshot.data['url'],
                              onSaved: _produtoBloc.saveImages,
                              validator: validateImage,
                            ),
                            TextFormField(
                                initialValue: snapshot.data['titulo'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                decoration: InputDecoration(
                                    labelText: 'Titulo',
                                    labelStyle: TextStyle(color: Colors.grey)),
                                validator: validateTitle,
                                onSaved: _produtoBloc.saveTitle),
                            TextFormField(
                              initialValue: snapshot.data['descricao'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              maxLines: 5,
                              validator: validateDescription,
                              onSaved: _produtoBloc.saveDescricao,
                            ),
                            TextFormField(
                                initialValue:
                                    snapshot.data["preco"]?.toStringAsFixed(2),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                decoration: InputDecoration(
                                    labelText: 'Preço',
                                    labelStyle: TextStyle(color: Colors.grey)),
                                validator: validatePrice,
                                onSaved: _produtoBloc.savePrice),
                            SizedBox(height: 16.0,),
                            Text(
                              'Tamanhos',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            AddProdutoSizes(
                              context: context,
                              initialValue: snapshot.data['sizes'],
                              onSaved: _produtoBloc.saveSizes,
                              validator: validateSize,
                            ),
                          ],
                        );
                }),
          ),
          StreamBuilder<bool>(
              stream: _produtoBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
