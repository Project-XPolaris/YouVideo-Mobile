import 'package:flutter/material.dart';

class ScreenWidthSelector extends StatelessWidget {
  final Widget verticalChild;
  final Widget? horizonChild;
  final String? forceLayout;

  const ScreenWidthSelector(
      {Key? key,
      required this.verticalChild,
      this.horizonChild,
      this.forceLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (forceLayout == "Vertical") {
      return this.verticalChild;
    }
    if (forceLayout == "Horizon") {
      return this.horizonChild ?? this.verticalChild;
    }
    bool isWide = MediaQuery.of(context).size.width > 600;
    if (isWide) {
      return this.horizonChild ?? this.verticalChild;
    }
    return this.verticalChild;
  }
}
