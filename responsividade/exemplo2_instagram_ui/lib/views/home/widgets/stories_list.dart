import 'package:exemplo2_instagram_ui/views/home/widgets/story_circle.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveWrapper.of(context).isMobile;
    return Container(
      padding: EdgeInsets.symmetric(vertical: mobile ? 8 : 20, horizontal: 5),
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(
          width: 16,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          return StoryCircle();
        },
      ),
    );
  }
}
