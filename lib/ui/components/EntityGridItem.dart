import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';

import '../../api/entity.dart';

class EntityGridItem extends StatelessWidget {
  final Entity entity;
  final Function(Entity)? onTap;

  const EntityGridItem({Key? key, required this.entity, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoverTitleGridItem(
        metaHeight: 48,
        metaContainerMagin: EdgeInsets.only(),
        title: entity.displayName,
        imageUrl: entity.coverUrl,
        borderRadius: 8,
        placeholderColor: Theme.of(context).colorScheme.secondaryContainer,
        placeHolderIcon: Icon(
          Icons.videocam,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          size: 48,
        ),
        failedIcon: Icons.videocam,
        imageAlignment: Alignment.bottomCenter,
        failedColor: Theme.of(context).colorScheme.secondaryContainer,
        titleMaxLine: 2,
        onTap: () {
          onTap?.call(entity);
        });
  }
}
