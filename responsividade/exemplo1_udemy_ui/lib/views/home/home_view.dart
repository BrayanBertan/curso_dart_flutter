import 'package:exemplo1_udemy_ui/breakpoints.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/app_bar/mobile_app_bar.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/app_bar/web_app_bar.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/top_section.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections_grade_views/grade_section.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections_vantagem_views/vatagem_section_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.black,
        drawer: constraints.maxWidth < MOBILE_BREAKPOINT ? Drawer() : null,
        appBar: constraints.maxWidth < MOBILE_BREAKPOINT
            ? PreferredSize(
                child: MobileAppBar(), preferredSize: Size(double.infinity, 56))
            : PreferredSize(
                child: WebAppBar(), preferredSize: Size(double.infinity, 72)),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1400),
              child: ListView(
                children: [TopSection(), VantagemSection(), GradeSection()],
              )),
        ),
      );
    });
  }
}
