import 'package:flutter/material.dart';

class LayoutViewModeMenu extends StatelessWidget {
  final Function(String mode) onModeChange;

  const LayoutViewModeMenu({Key? key, required this.onModeChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.view_compact_rounded),
      onSelected: (String value) {
        onModeChange(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'Default',
          child: Text('Default'),
        ),
        PopupMenuItem<String>(
          value: 'Vertical',
          child: Text('List'),
        ),
        PopupMenuItem<String>(
          value: 'Horizon',
          child: Text('Grid'),
        ),
      ],
    );
  }
}
