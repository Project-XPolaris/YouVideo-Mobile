import 'package:flutter/material.dart';
import 'package:youvideo/api/library.dart';

class LibraryItem extends StatelessWidget {
  final Library library;
  final Function onTap;
  LibraryItem({this.library,this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.video_library),
      title: Text(library.name),
    );
  }
}
