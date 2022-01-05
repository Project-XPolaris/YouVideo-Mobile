import 'package:flutter/material.dart';

import 'VideoCover.dart';

class VideoItem extends StatelessWidget {
  final String? coverUrl;
  final String name;
  final String type;
  final Function()? onTap;
  final double coverRatio;
  VideoItem({this.coverUrl, this.name = "Unknown",this.onTap,this.type = "video",this.coverRatio = 1});

  @override
  Widget build(BuildContext context) {
    var baseWidth = 120.toDouble();
    var height = baseWidth / coverRatio;
    if (height > 300) {
      height = 120;
    }
    return Padding(
      padding: EdgeInsets.only(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: VideoCover(
              coverUrl: coverUrl,
              onTap: onTap,
              borderRadius: 8,
              width: baseWidth,
              height: 120,
            ),
            width: baseWidth,
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

