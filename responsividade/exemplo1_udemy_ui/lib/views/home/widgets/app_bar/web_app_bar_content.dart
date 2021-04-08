import 'package:flutter/material.dart';

class WebAppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        return Row(
          children: [
            Expanded(
                child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[600])),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {}),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Pesquise',
                          isCollapsed: true),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(
              width: 4,
            ),
            if (constraints.maxWidth >= 400)
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Aprender',
                    style: TextStyle(color: Colors.white),
                  )),
            if (constraints.maxWidth >= 500)
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Flutter',
                    style: TextStyle(color: Colors.white),
                  ))
          ],
        );
      },
    ));
  }
}
