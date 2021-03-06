import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoCover extends StatelessWidget {
  String coverUrl;
  Function() onTap;
  double width;
  double height;
  double borderRadius;

  VideoCover(
      {this.coverUrl,
      this.onTap,
      this.width = 140,
      this.height = 120,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    if (coverUrl != null) {
      return GestureDetector(
        child: ClipRRect(
          child: CachedNetworkImage(
            width: width,
            height: height,
            fit: BoxFit.cover,
            imageUrl:  coverUrl,
            placeholder: (context, url) => Container(color: Colors.white10,),
            errorWidget: (context, url, error) => Container(color: Colors.white10,),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onTap: onTap,
      );
    }
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          color: Colors.redAccent,
          child: Center(
            child: Icon(
              Icons.videocam_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
