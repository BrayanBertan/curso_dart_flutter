import 'package:exemplo2_instagram_ui/views/home/widgets/post_widget.dart';
import 'package:exemplo2_instagram_ui/views/home/widgets/responsive_appbar.dart';
import 'package:exemplo2_instagram_ui/views/home/widgets/right_panel.dart';
import 'package:exemplo2_instagram_ui/views/home/widgets/stories_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 52),
        child: ResponsiveAppBar(),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Row(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    StoriesList(),
                    PostWidget(),
                    PostWidget(),
                    PostWidget(),
                  ],
                )),
                RightPanel(),
              ],
            )),
      ),
    );
  }
}
