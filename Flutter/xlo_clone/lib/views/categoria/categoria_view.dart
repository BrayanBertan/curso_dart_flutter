import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/components/custom_drawer/error_box.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/stores/categoria_store.dart';

class CategoriaPage extends StatelessWidget {
  CategoriaPage({this.selected, this.ShowAll = true});
  final Categoria selected;
  final bool ShowAll;

  final CategoriaStore categoriaStore = GetIt.I<CategoriaStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Observer(
            builder: (_) {
              if (categoriaStore.error != null)
                return ErrorBox(
                  message: categoriaStore.error,
                );
              else if (categoriaStore.loading)
                return Center(child: CircularProgressIndicator());
              else {
                final categorias = ShowAll
                    ? categoriaStore.getAallCategorias
                    : categoriaStore.categoriasList;
                return ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(categorias[index]);
                        },
                        child: Container(
                          height: 50,
                          color: categorias[index].id == selected?.id
                              ? Colors.deepPurple
                              : Colors.white,
                          child: Center(
                            child: Text(categorias[index].descricao),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
