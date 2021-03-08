import 'package:flutter/material.dart';

class VideoFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFF303030),
            child: Text(
              "Filter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text("Order",style: TextStyle(color: Colors.white70),),
          ),
          Wrap(
            children: [
              FilterChip(label: Text("id asc"), onSelected: (selected) {},selected: true, selectedColor: Colors.red,),
              FilterChip(label: Text("id asc"), onSelected: (selected) {},selected: true,),
              FilterChip(label: Text("id asc"), onSelected: (selected) {},selected: true,),
              FilterChip(label: Text("id asc"), onSelected: (selected) {},selected: true,)
            ],
          )


        ],
      ),
    );
  }
}
