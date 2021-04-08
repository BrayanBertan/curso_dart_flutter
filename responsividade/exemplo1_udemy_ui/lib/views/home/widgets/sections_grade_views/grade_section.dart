import 'package:exemplo1_udemy_ui/views/home/widgets/course_item.dart';
import 'package:flutter/material.dart';

class GradeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(
            vertical: 16, horizontal: constraints.maxWidth >= 1400 ? 0 : 16),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CourseItem();
        },
      );
    });
  }
}
