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
          placeholderColor: Colors.red,
          placeHolderIcon: Icon(Icons.videocam),
          failedIcon: Icons.videocam,
          failedColor: Colors.red,
          onTap: () {
            onTap?.call(entity);
          }),
    );
  }
}
