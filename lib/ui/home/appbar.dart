import 'package:flutter/material.dart';
import 'package:youvideo/ui/search/index.dart';

renderHomeAppBar(BuildContext context, {List<Widget> actions = const []}) {
  return AppBar(
    title: Text("YouVideo"),
    elevation: 0,
    actions: [
      ...actions,
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
          icon: Icon(Icons.search))
    ],
  );
}
