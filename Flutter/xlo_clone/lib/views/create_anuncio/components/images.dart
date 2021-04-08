import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_clone/stores/create_image_store.dart';
import 'package:xlo_clone/views/create_anuncio/components/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  final CreateImageStore createImageStore;

  ImagesField(this.createImageStore);
  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createImageStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          height: 120,
          color: Colors.grey[500],
          child: Observer(
            builder: (_) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: createImageStore.images.length + 1,
                  itemBuilder: (_, index) {
                    return createImageStore.images.length == index
                        ? GestureDetector(
                            onTap: createImageStore.images.length < 5
                                ? () {
                                    if (Platform.isAndroid) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) => ImageSourcePage(
                                              onImageSelected,
                                              createImageStore));
                                    } else {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => ImageSourcePage(
                                              onImageSelected,
                                              createImageStore));
                                    }
                                  }
                                : null,
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: 44,
                                backgroundColor: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '+',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        : GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.file(
                                              createImageStore.images[index]),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                createImageStore.images
                                                    .removeAt(index);
                                              },
                                              child: Text('Deletar imagem?'))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: 44,
                                backgroundImage: createImageStore.images[index]
                                        is File
                                    ? FileImage(createImageStore.images[index])
                                    : NetworkImage(
                                        createImageStore.images[index]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '+',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  });
            },
          ),
        ),
        Observer(builder: (_) {
          if (createImageStore.imagesError != null)
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5),
              child: Text(
                createImageStore.imagesError,
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.red),
              ),
            );
          else
            return Container();
        })
      ],
    );
  }
}
