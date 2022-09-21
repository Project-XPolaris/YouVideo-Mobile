import 'package:flutter/material.dart';
import 'package:youvideo/history-list/wrap.dart';
import 'package:youvideo/tag-list/tags.dart';

class HomeMyHorizon extends StatelessWidget {
  const HomeMyHorizon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 72),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  child: CircleAvatar(
                    child: Icon(Icons.person_rounded,color: Theme.of(context).colorScheme.onSecondaryContainer,size: 48,),
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text("My",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w200),),
                )
              ],
            ),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 16,right: 16,top: 32),
            child:ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.bookmark_rounded),
                  title: Text("Tag"),
                  onTap: (){
                    TagListPage.launch(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.history_rounded),
                  title: Text("History"),
                  onTap: (){
                    HistoryListPageWrap.launch(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
