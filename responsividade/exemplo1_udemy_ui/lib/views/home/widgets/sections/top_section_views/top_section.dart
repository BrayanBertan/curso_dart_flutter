import 'package:exemplo1_udemy_ui/breakpoints.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/background_image_mobile.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/background_image_tablet.dart';
import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/background_image_web.dart';
import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      return maxWidth >= 1200
          ? BackGroundImageWeb()
          : maxWidth >= MOBILE_BREAKPOINT
              ? BackGroundImageTablet()
              : BackGroundImageMobile();
    });
  }
}
