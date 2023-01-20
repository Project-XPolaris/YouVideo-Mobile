import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/ui/library/provider.dart';

import 'layout.dart';

class LibraryPage extends StatelessWidget {
  final String title;
  final Library library;

  LibraryPage({required this.title, required this.library});

  static Launch(BuildContext context, Library library) {
    if (library.id == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LibraryPage(
                title: library.name ?? "",
                library: library,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryProvider>(
        create: (_) =>
            LibraryProvider(libraryId: library.id ?? 0, title: title),
        child: Consumer<LibraryProvider>(builder: (context, provider, child) {
          provider.loadData();
          return LibraryLayout();
        }));
  }
}
