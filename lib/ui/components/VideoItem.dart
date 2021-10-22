import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'VideoCover.dart';

class VideoItem extends StatelessWidget {
  String? coverUrl;
  String name;
  String type;
  Function()? onTap;
  VideoItem({this.coverUrl, this.name = "Unknown",this.onTap,this.type = "video"});

  @override
  Widget build(BuildContext context) {
    double width = 120;
    double height = 75;
    if (type == 'film') {
      width = 80;
      height = 120;
    }
    return Padding(
      padding: EdgeInsets.only(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Center(
              child: VideoCover(
                coverUrl: coverUrl,
                onTap: onTap,
                width: width,
                height: height,
                borderRadius: 6,
              ),
            ),
            width: 120,
            height: 120,
          )
          ,
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

