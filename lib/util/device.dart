import 'package:flutter/material.dart';

import '../consts.dart';

bool isLargeMode(BuildContext context) {
  return MediaQuery.of(context).size.width > viewBreakPoint;
}
