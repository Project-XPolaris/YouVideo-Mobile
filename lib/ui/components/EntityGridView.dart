import 'package:flutter/material.dart';
import 'package:youui/components/gridview.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/ui/components/EntityGridItem.dart';
import 'package:youvideo/util/listview.dart';

class EntityGridView extends StatelessWidget {
  final List<Entity> entities;
  final Function(Entity)? onItemClick;
  final Function()? onLoadMore;
  const EntityGridView({Key? key, required this.entities,this.onItemClick,this.onLoadMore}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _controller = createLoadMoreController((){
      onLoadMore?.call();
    });
    return Container(
      child: ResponsiveGridView(
        controller: _controller,
        children: this.entities.map((entity) {
          return EntityGridItem(entity: entity,onTap: onItemClick,);
        }).toList(),
        itemWidth: 160,
      ),
    );
  }
}
