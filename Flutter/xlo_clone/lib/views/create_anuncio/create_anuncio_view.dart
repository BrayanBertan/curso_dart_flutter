import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_clone/components/custom_drawer/error_box.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/stores/create_image_store.dart';
import 'package:xlo_clone/stores/page_store.dart';
import 'package:xlo_clone/views/categoria/categoria_view.dart';
import 'package:xlo_clone/views/create_anuncio/components/images.dart';
import 'package:xlo_clone/views/meus_anuncios/meus_anuncios_view.dart';

class CreateAnuncioPage extends StatefulWidget {
  Anuncio anuncio;
  CreateAnuncioPage({this.anuncio});
  @override
  _CreateAnuncioPageState createState() =>
      _CreateAnuncioPageState(anuncio: anuncio ?? Anuncio());
}

class _CreateAnuncioPageState extends State<CreateAnuncioPage> {
  Anuncio anuncio;
  _CreateAnuncioPageState({this.anuncio})
      : editing = anuncio != null,
        createImageStore = CreateImageStore(anuncio);
  CreateImageStore createImageStore;

  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => createImageStore.anuncio, () {
      if (editing)
        Navigator.of(context).pop(true);
      else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MeusAnunciosPages(pageInicial: 1)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: editing ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar anuncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImagesField(createImageStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          initialValue: createImageStore.titulo,
                          onChanged: createImageStore.setTitulo,
                          decoration: InputDecoration(
                              labelText: 'Titulo*',
                              contentPadding: EdgeInsets.all(8.0),
                              errorText: createImageStore.tituloError),
                        );
                      }),
                      Observer(builder: (_) {
                        return TextFormField(
                          initialValue: createImageStore.descricao,
                          onChanged: createImageStore.setDescricao,
                          decoration: InputDecoration(
                              errorText: createImageStore.descricaoError,
                              labelText: 'Descrição*',
                              contentPadding: EdgeInsets.all(8.0)),
                          maxLines: null,
                        );
                      }),
                      Observer(builder: (_) {
                        return ListTile(
                          dense: true,
                          onTap: () async {
                            final response = await showDialog(
                                context: (context),
                                builder: (context) => CategoriaPage(
                                      selected: createImageStore.categoria,
                                      ShowAll: false,
                                    ));
                            if (response != null)
                              createImageStore.setCategoria(response);
                          },
                          title: Text('Categoria*'),
                          subtitle: createImageStore.categoria == null
                              ? Text(
                                  createImageStore.categoriaError,
                                  style: TextStyle(color: Colors.red),
                                )
                              : Text(createImageStore.categoria.descricao),
                          trailing: Icon(
                            Icons.keyboard_arrow_down,
                            size: 15,
                          ),
                        );
                      }),
                      Divider(
                        color: Colors.black,
                        height: 15,
                      ),
                      Observer(builder: (_) {
                        return Column(
                          children: [
                            TextFormField(
                              initialValue: createImageStore.cepStore.cep,
                              onChanged: createImageStore.cepStore.setCep,
                              decoration: InputDecoration(
                                labelText: 'CEP*',
                                contentPadding: EdgeInsets.all(8.0),
                                errorText:
                                    createImageStore.cepStore.error == null
                                        ? ''
                                        : createImageStore.cepStore.error,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter()
                              ],
                            ),
                            createImageStore.cepStore.address == null
                                ? Text('')
                                : ListTile(
                                    leading: Text(createImageStore
                                        .cepStore.address.distrito),
                                    title: Text(createImageStore
                                        .cepStore.address.cidade.nome),
                                    trailing: Text(createImageStore
                                        .cepStore.address.uf.nome),
                                    dense: true,
                                  )
                          ],
                        );
                      }),
                      Observer(builder: (_) {
                        return TextFormField(
                          initialValue: createImageStore.precoText,
                          onChanged: createImageStore.setPrecoText,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RealInputFormatter(centavos: true)
                          ],
                          decoration: InputDecoration(
                            errorText: createImageStore.precoError,
                            prefixText: 'R\$',
                            labelText: 'Preço*',
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Observer(builder: (_) {
                            return Checkbox(
                                value: createImageStore.hidePhone,
                                onChanged: (value) {
                                  createImageStore.setHidePhone(value);
                                });
                          }),
                          Expanded(
                            child: Text('Ocultar o meu telefone nesse anuncio'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Observer(
                        builder: (_) {
                          return ErrorBox(
                            message: createImageStore.erroSend,
                          );
                        },
                      ),
                      Observer(builder: (_) {
                        return Text('${createImageStore.formValid}');
                      }),
                      SizedBox(
                        height: 50,
                        child: Observer(
                          builder: (_) {
                            return GestureDetector(
                              onTap: createImageStore.invalidSendPressed,
                              child: ElevatedButton(
                                onPressed: createImageStore.sendValid,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.purple;
                                      else if (states
                                          .contains(MaterialState.disabled))
                                        return Colors.purple;
                                      return Colors
                                          .purple; // Use the component's default.
                                    },
                                  ),
                                ),
                                child: Text('Enviar'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Observer(builder: (_) {
                return IgnorePointer(
                  ignoring: !createImageStore.cepStore.loading ||
                      !createImageStore.loading,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    color: createImageStore.cepStore.loading ||
                            createImageStore.loading
                        ? Colors.black26
                        : Colors.transparent,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
