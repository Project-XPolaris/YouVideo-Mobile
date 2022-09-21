import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/layout.dart';
import 'package:youvideo/ui/home/tabs/category/horizon.dart';

class HomeCategoryWrap extends StatelessWidget {
  const HomeCategoryWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseHomeLayout(
      child: ScreenWidthSelector(
        verticalChild: HomeCategoryHorizon(),
        horizonChild: HomeCategoryHorizon(),
      ),
    );
  }
}
