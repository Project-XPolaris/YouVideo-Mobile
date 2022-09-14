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
    return Container(
      child: CoverTitleGridItem(
          metaHeight: 32,
          metaContainerMagin: EdgeInsets.only(),
          title: entity.displayName,
          imageUrl: entity.coverUrl,
          borderRadius: 8,
          placeholderColor: Theme.of(context).colorScheme.primary,
          placeHolderIcon: Icon(Icons.videocam),
          failedIcon: Icons.videocam,
          failedColor: Theme.of(context).colorScheme.primary,
          onTap: () {
            onTap?.call(entity);
          }),
    );
  }
}
