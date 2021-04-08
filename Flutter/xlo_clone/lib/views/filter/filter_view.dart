import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/stores/filter_store.dart';
import 'package:xlo_clone/stores/home_store.dart';

class FilterPage extends StatelessWidget {
  FilterStore filterStore = GetIt.I<HomeStore>().cloneFilter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar busca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.all(30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Localização',
                    style: TextStyle(color: Colors.purple),
                  ),
                  DropdownButton(
                    value: '1',
                    onChanged: (value) {},
                    items: [
                      DropdownMenuItem(value: '1', child: Text('Cidade')),
                      DropdownMenuItem(value: '2', child: Text('xd'))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DropdownButton(
                    value: '1',
                    onChanged: (value) {},
                    items: [
                      DropdownMenuItem(value: '1', child: Text('Cidade')),
                      DropdownMenuItem(value: '2', child: Text('xd'))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Ordenar por',
                    style: TextStyle(color: Colors.purple),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(builder: (_) {
                    return Row(
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              filterStore.setOrderBy(OrderBy.DATE);
                            },
                            child: Text(
                              'Data',
                              style: TextStyle(
                                  color: filterStore.orderBy == OrderBy.DATE
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: filterStore.orderBy == OrderBy.DATE
                                  ? Colors.purple
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              filterStore.setOrderBy(OrderBy.PRICE);
                            },
                            child: Text(
                              'Preço',
                              style: TextStyle(
                                  color: filterStore.orderBy == OrderBy.PRICE
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: filterStore.orderBy == OrderBy.PRICE
                                  ? Colors.purple
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                              )),
                        )
                      ],
                    );
                  }),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Preço',
                    style: TextStyle(color: Colors.purple),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              filterStore.setMin(
                                  int.tryParse(value.replaceAll('.', '')));
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              prefixText: 'R\$',
                              labelText: 'Min',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(centavos: false)
                            ],
                            initialValue: filterStore.min != null
                                ? '${filterStore.min}'
                                : '',
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: TextFormField(
                                onChanged: (value) {
                                  filterStore.setMax(
                                      int.tryParse(value.replaceAll('.', '')));
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    isDense: true,
                                    prefixText: 'R\$',
                                    labelText: 'Max',
                                    border: OutlineInputBorder()),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  RealInputFormatter(centavos: false)
                                ],
                                initialValue: filterStore.max != null
                                    ? '${filterStore.max}'
                                    : '')),
                      ],
                    );
                  }),
                  Observer(builder: (_) {
                    if (filterStore.precoError != null)
                      return Text('${filterStore.precoError}');
                    return Container();
                  }),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Tipo de anunciante',
                    style: TextStyle(color: Colors.purple),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(builder: (_) {
                    return Wrap(
                      runSpacing: 4,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (filterStore.isTypeParticular) {
                              if (filterStore.isTypeProfissional)
                                filterStore
                                    .resetVendorType(VENDOR_TYPE_PARTICULAR);
                              else
                                filterStore
                                    .selectVendorType(VENDOR_TYPE_PROFISISONAL);
                            } else {
                              filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: filterStore.isTypeParticular
                                  ? Colors.purple
                                  : Colors.transparent,
                              border: Border.all(
                                color: filterStore.isTypeParticular
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Particular',
                              style: TextStyle(
                                color: filterStore.isTypeParticular
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            if (filterStore.isTypeProfissional) {
                              if (filterStore.isTypeParticular)
                                filterStore
                                    .resetVendorType(VENDOR_TYPE_PROFISISONAL);
                              else
                                filterStore
                                    .selectVendorType(VENDOR_TYPE_PARTICULAR);
                            } else {
                              filterStore
                                  .setVendorType(VENDOR_TYPE_PROFISISONAL);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: filterStore.isTypeProfissional
                                  ? Colors.purple
                                  : Colors.transparent,
                              border: Border.all(
                                color: filterStore.isTypeProfissional
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Profissional',
                              style: TextStyle(
                                color: filterStore.isTypeProfissional
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(builder: (_) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onSurface: Colors.orange,
                          primary: Colors.orange,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: filterStore.isFormValid
                            ? () {
                                filterStore.setFilter();
                                Navigator.of(context).pop();
                              }
                            : null,
                        child: Text('Filtrar'));
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
