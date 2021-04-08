import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  final Function({String texto, PickedFile foto}) sendMessage;
  TextComposer(this.sendMessage);
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final _texto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.camera), onPressed: () async{
            final PickedFile imgFile = await ImagePicker().getImage(source: ImageSource.camera);
            if(imgFile == null) {
              return;
            }else{
              widget.sendMessage(foto:imgFile);
            }

          }),
          Expanded(
              child: TextField(
            controller: _texto,
            decoration:
                InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
            onChanged: (value) {
              setState(() {
                _isComposing = value.isNotEmpty;
              });
            },
            onSubmitted: (value) {
              widget.sendMessage(texto:value);
              _texto.clear();
              _isComposing = false;
            },
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(texto:_texto.text);
                    _texto.clear();
                    _isComposing = false;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
