import 'package:flutter/material.dart';

import 'VideoCover.dart';

class EntityItem extends StatelessWidget {
  final String? coverUrl;
  final String name;
  final Function()? onTap;
  final double coverRatio;
  EntityItem({this.coverUrl, this.name = "Unknown",this.onTap,this.coverRatio = 1});

  @override
  Widget build(BuildContext context) {
    var baseWidth = 120.toDouble();
    double ratio = 1;
    ratio = coverRatio;
    var height = baseWidth / ratio;
    if (height > 300) {
      height = 120;
    }
    return Padding(
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: VideoCover(
              coverUrl: coverUrl,
              onTap: onTap,
              width: baseWidth,
              height: height,
              borderRadius: 8,
            ),
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
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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

