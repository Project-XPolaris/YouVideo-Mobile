import 'package:flutter/material.dart';

class GirdViewModeMenu extends StatelessWidget {
  final Function(String gridViewMode) onModeChange;

  const GirdViewModeMenu({Key? key, required this.onModeChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.view_comfortable_rounded),
      onSelected: (String value) {
        onModeChange(value);
      },
      itemBuilder: (BuildContext context) =>
      <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'Large',
          child: Text('Large'),
        ),
        PopupMenuItem<String>(
          value: 'Medium',
          child: Text('Medium'),
        ),
        PopupMenuItem<String>(
          value: 'Small',
          child: Text('Small'),
        ),
      ],
    );
  }
}
