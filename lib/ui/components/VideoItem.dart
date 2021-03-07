import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'VideoCover.dart';

class VideoItem extends StatelessWidget {
  String coverUrl;
  String name;
  Function() onTap;
  VideoItem({this.coverUrl, this.name,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          VideoCover(
            coverUrl: coverUrl,
            onTap: onTap,
            width: 120,
            height: 75,
            borderRadius: 6,
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
}

