import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcePage extends StatelessWidget {
  final Function(File) onImageSelected;
  final CreateImageStore;

  ImageSourcePage(this.onImageSelected, this.CreateImageStore);
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? BottomSheet(
            onClosing: () {},
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(onPressed: getFromCamera, child: Text('Câmera')),
                  TextButton(onPressed: getFromGallery, child: Text('Galeria')),
                ],
              );
            })
        : CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
                onPressed: Navigator.of(context).pop, child: Text('Cancelar')),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: getFromCamera, child: Text('Câmera')),
              CupertinoActionSheetAction(
                  onPressed: getFromGallery, child: Text('Câmera'))
            ],
          );
  }

  void getFromCamera() async {
    print('xd');
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    if (file == null) return;
    final image = File(file.path);
    imageSelected(image);
  }

  void getFromGallery() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    if (file == null) return;
    final image = File(file.path);
    imageSelected(image);
  }

  void imageSelected(File image) async {
    final pic = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(toolbarTitle: 'editar imagem'),
        iosUiSettings: IOSUiSettings(title: 'editar imagem'));

    if (image != null) onImageSelected(pic);
  }
}
