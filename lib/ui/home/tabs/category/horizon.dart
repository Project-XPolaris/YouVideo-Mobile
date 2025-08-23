import 'package:flutter/material.dart';
import 'package:youvideo/entity-list/wrap.dart';
import 'package:youvideo/meta-list/wrap.dart';
import 'package:youvideo/ui/home/tabs/library/library.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/provider.dart';

class HomeCategoryHorizon extends StatelessWidget {
  const HomeCategoryHorizon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          ListTile(
            title: Text("Libraries"),
            leading: Icon(Icons.video_library_rounded),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LibrariesTabPage()),
              );
            },
          ),
          ListTile(
            title: Text("Meta"),
            leading: Icon(Icons.info_rounded),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              MetaListWrap.launch(context);
            },
          ),
          ListTile(
            title: Text("Entity"),
            leading: Icon(Icons.apps_rounded),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              EntityListWrap.launch(context);
            },
          ),
        ],
      ),
    );
  }
}
