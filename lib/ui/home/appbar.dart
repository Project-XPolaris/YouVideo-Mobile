import 'package:flutter/material.dart';
import 'package:youvideo/ui/search/index.dart';

renderHomeAppBar(BuildContext context){
  return AppBar(
    title: Text("YouVideo",style: TextStyle(color:Colors.red),),
    backgroundColor: Color(0x1F1F1F),
    elevation: 0,
    actions: [
      IconButton(onPressed: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchPage()),);
      }, icon: Icon(Icons.search,color: Colors.white,))
    ],
  );
}