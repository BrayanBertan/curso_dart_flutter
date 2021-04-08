import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/categoria_bloc.dart';
import 'package:loja_gerencia/widgets/image_source_sheet.dart';

class EditCategoriaDialog extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final CategoriaBloc _categoriaBloc;
  final TextEditingController controller;

  EditCategoriaDialog(this.documentSnapshot)
      : _categoriaBloc = CategoriaBloc(documentSnapshot),
        controller = TextEditingController(
            text: documentSnapshot != null
                ? documentSnapshot.data['titulo']
                : '');

  @override
  _EditCategoriaDialogState createState() => _EditCategoriaDialogState();
}

class _EditCategoriaDialogState extends State<EditCategoriaDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {},
                child: StreamBuilder(
                    stream: widget._categoriaBloc.outImage,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ImageSouceSheet((image) {
                                          Navigator.of(context).pop();
                                          if (image != null) {
                                            widget._categoriaBloc
                                                .setImage(image);
                                          }
                                        }));
                              },
                              child: CircleAvatar(
                                child: snapshot.data is File
                                    ? Image.file(
                                        snapshot.data,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(snapshot.data,
                                        fit: BoxFit.cover),
                              ),
                            )
                          : Icon(Icons.local_pizza_outlined);
                    }),
              ),
              title: StreamBuilder<String>(
                  stream: widget._categoriaBloc.outCategoria,
                  builder: (context, snapshot) {
                    return TextField(
                        onChanged: (value) {
                          widget._categoriaBloc.setTitulo(value);
                        },
                        controller: widget.controller,
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                        ));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<bool>(
                    stream: widget._categoriaBloc.outDelete,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? FlatButton(
                              onPressed: snapshot.data
                                  ? () {
                                      widget._categoriaBloc.delete();
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: Text('excluir'))
                          : Container();
                    }),
                StreamBuilder<bool>(
                    stream: widget._categoriaBloc.SubmmitedValue,
                    builder: (context, snapshot) {
                      return FlatButton(
                          onPressed: snapshot.hasData
                              ? () async {
                                  await widget._categoriaBloc.saveCategoria();
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: Text('salvar'));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
