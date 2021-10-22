import 'package:flutter/material.dart';

class ActionItem {
  String title;
  Function()? onTap;
  ActionItem({required this.title,this.onTap});
}

class ActionSelectBottomSheet extends StatelessWidget {
  final List<ActionItem> actions;
  final String title;
  final double height;
  ActionSelectBottomSheet({this.actions = const[], required this.title,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ),
          ...actions.map((action) {
            return ListTile(title: Text(action.title), onTap: action.onTap,);
          })
        ],
      ),
    );
  }
}
