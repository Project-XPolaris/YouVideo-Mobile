import 'package:flutter/material.dart';

class VideoCover extends StatelessWidget {
  final String? coverUrl;
  final Function()? onTap;
  final double width;
  final double height;
  final double borderRadius;

  VideoCover(
      {this.coverUrl,
      this.onTap,
      this.width = 140,
      this.height = 120,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    var url = coverUrl;
    if (url != null) {
      return GestureDetector(
        child: ClipRRect(
          child: Image.network(
            url,
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            width: width,
            height: height,
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
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Icon(
              Icons.videocam_rounded,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
