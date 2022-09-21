import 'package:flutter/material.dart';
import 'package:youvideo/api/library.dart';

class LibraryItem extends StatelessWidget {
  final Library library;
  final Function() onTap;
  LibraryItem({required this.library,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.video_library_rounded),
      title: Text(library.name ?? ""),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
