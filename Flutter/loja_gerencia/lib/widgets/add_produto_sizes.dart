import 'package:flutter/material.dart';

class AddProdutoSizes extends FormField<List> {
  AddProdutoSizes({
    BuildContext context,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    List initialValue,
    AutovalidateMode autoValidate = AutovalidateMode.disabled,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autoValidate,
            builder: (state) {
              final _controllerText = TextEditingController();
              return SizedBox(
                height: 30.0,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5),
                  scrollDirection: Axis.horizontal,
                  children: state.value.map((size) {
                    return GestureDetector(
                      onLongPress: () {
                        state.didChange(state.value..remove(size));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border:
                              Border.all(color: Colors.pinkAccent, width: 3.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          size,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList()
                    ..add(GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _controllerText,
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            child: FlatButton(
                                                onPressed: () {
                                                  state.didChange(state.value
                                                    ..add(
                                                        _controllerText.text));
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('add')))
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: state.hasError == 0
                                  ? Colors.red
                                  : Colors.pinkAccent,
                              width: 3.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                ),
              );
            });
}
