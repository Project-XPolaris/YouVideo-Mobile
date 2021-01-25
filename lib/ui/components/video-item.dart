import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class VideoItem extends StatelessWidget {
  String coverUrl;
  String name;
  Function() onTap;
  VideoItem({this.coverUrl, this.name,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoCover(
            coverUrl: coverUrl,
            onTap: onTap,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoCover extends StatelessWidget {
  String coverUrl;
  Function() onTap;
  VideoCover({this.coverUrl,this.onTap});

  @override
  Widget build(BuildContext context) {
    if (coverUrl != null) {
      return GestureDetector(
        child: Image(
          image: NetworkImage(
            coverUrl,
          ),
          width: 140,
          height: 120,
          fit: BoxFit.cover,
        ),
        onTap: onTap,
      );
    }
    return InkWell(
      child: Container(
        width: 140,
        height: 120,
        color: Colors.redAccent,
        child: Center(
          child: Icon(
            Icons.videocam_rounded,
            color: Colors.white,
          ),
        ),

      ),
      onTap: onTap,
    );
  }
}
