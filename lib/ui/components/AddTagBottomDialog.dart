import 'package:flutter/material.dart';

class AddTagBottomDialog extends StatefulWidget {
  final Function(String text) onCreate;

  AddTagBottomDialog({required this.onCreate});

  @override
  _AddTagBottomDialogState createState() => _AddTagBottomDialogState();
}

class _AddTagBottomDialogState extends State<AddTagBottomDialog> {
  String? inputText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New tag name',
                    prefixIcon: Icon(Icons.tag)),
                onChanged: (text) => this.setState(() {
                  inputText = text;
                }),
              ),
              TextButton(
                  onPressed: () {
                    var text = inputText;
                    if (text != null && text.isNotEmpty) {
                      widget.onCreate(text);
                    }
                  },
                  child: Text("Create"))
            ],
          ),
        ),
      ]),
    );
  }
}
