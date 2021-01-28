import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoCover.dart';

class VideoItemHorizon extends StatelessWidget {
  String coverUrl;
  String name;
  Function() onTap;
  double coverWidth;
  double coverHeight;

  EdgeInsets padding = EdgeInsets.all(0);

  VideoItemHorizon(
      {this.coverUrl,
      this.name,
      this.onTap,
      this.padding,
      this.coverWidth = 240,
      this.coverHeight = 120});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: coverWidth,
        height: coverHeight + 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoCover(
              borderRadius: 8.0,
              coverUrl: coverUrl,
              width: coverWidth,
              height: coverHeight,
              onTap: onTap,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
