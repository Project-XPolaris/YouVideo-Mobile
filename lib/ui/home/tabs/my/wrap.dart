import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/layout.dart';
import 'package:youvideo/ui/home/tabs/my/horizon.dart';

class HomeMyWrap extends StatelessWidget {
  const HomeMyWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseHomeLayout(
      child: ScreenWidthSelector(
        verticalChild: HomeMyHorizon(),
        horizonChild: HomeMyHorizon(),
      ),
    );
  }
}
