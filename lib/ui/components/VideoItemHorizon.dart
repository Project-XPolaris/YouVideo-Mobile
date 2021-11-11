import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoCover.dart';
class VideoItemHorizon extends StatelessWidget {
  final String? coverUrl;
  final String name;
  final Function()? onTap;
  final double coverWidth;
  final double coverHeight;
  final double maxCoverWidth;
  final double maxCoverHeight;

  final EdgeInsets padding;

  VideoItemHorizon(
      {this.coverUrl,
      this.name = "Unknown",
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.coverWidth = 240,
      this.coverHeight = 120,
      this.maxCoverHeight = 240,
      this.maxCoverWidth = 240});

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
            Container(
              child: Center(
                child: VideoCover(

                  coverUrl: coverUrl,
                  width: coverWidth,
                  height: coverHeight,
                  onTap: onTap,
                ),
              ),
              width: maxCoverWidth,
              height: maxCoverHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
