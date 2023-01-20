import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/library/provider.dart';

class LibraryEntities extends StatelessWidget {
  LibraryEntities();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    return Scaffold(
      body: Builder(builder: (context) {
        return Stack(
          children: [],
        );
      }),
    );
  }
}
