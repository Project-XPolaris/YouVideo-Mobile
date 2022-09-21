import 'package:flutter/material.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/entity-list/wrap.dart';
import 'package:youvideo/meta-list/wrap.dart';

class HomeCategoryHorizon extends StatelessWidget {
  const HomeCategoryHorizon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
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
          )
        ],
      ),
    );
  }
}
