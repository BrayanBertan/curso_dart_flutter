import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final TextEditingController controller;
  final String currentSearch;
  SearchDialog(this.currentSearch)
      : controller = TextEditingController(text: currentSearch);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.clear,
                    icon: Icon(Icons.close),
                  ),
                  border: InputBorder.none),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                Navigator.of(context).pop(value);
              },
              autofocus: true,
            ),
          ),
        )
      ],
    );
  }
}
