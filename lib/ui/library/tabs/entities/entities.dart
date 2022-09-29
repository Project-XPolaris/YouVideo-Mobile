import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/library/tabs/videos/list-wrap.dart';

import '../../layout.dart';

class LibraryEntities extends StatelessWidget {

  LibraryEntities();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    return Scaffold(
      body: Builder(builder: (context) {
        return Stack(
          children: [

          ],
        );
      }),
    );
  }
}
