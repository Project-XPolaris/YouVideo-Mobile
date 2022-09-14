import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';

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
    return Container(
      padding: padding,
      child: CoverTitleGridItem(
          borderRadius: 4,
          metaHeight: 32,
          metaContainerMagin: EdgeInsets.only(),
          title: name,
          imageBoxFit: BoxFit.contain,
          placeHolderIcon: Icon(
            Icons.videocam,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 48,
          ),
          placeholderColor: Theme.of(context).colorScheme.primaryContainer,
          imageUrl: coverUrl,
          onTap: () {
            onTap?.call();
          }),
    );
  }
}
