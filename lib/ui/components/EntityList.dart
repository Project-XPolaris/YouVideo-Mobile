import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/EntityItem.dart';
import 'package:youvideo/util/listview.dart';

import '../../api/entity.dart';

class EntityList extends StatefulWidget {
  final Function onLoadMore;
  final Function(Entity)? onItemClick;
  final List<Entity> entities;

  const EntityList({
    Key? key,
    this.onItemClick,
    required this.onLoadMore,
    this.entities = const [],
  }) : super(key: key);

  @override
  _EntityListState createState() => _EntityListState();
}

class _EntityListState extends State<EntityList> {
  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(widget.onLoadMore);
    return ListView(
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
      children: widget.entities.map((entity) {
        return Padding(
          padding: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
          child: EntityItem(
            coverUrl: entity.coverUrl,
            name: entity.displayName,
            coverRatio: entity.ratio,
            onTap: () {
              var handler = this.widget.onItemClick;
              if (handler != null) {
                handler(entity);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
