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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VideoCover(
                coverUrl: coverUrl,
                onTap: onTap,
                width: 175,
                height: 120,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16,top: 16,bottom: 16),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white12,
          )
        ],
      ),
    );
  }
}

