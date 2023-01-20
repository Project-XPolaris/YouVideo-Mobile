import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/viewport-selector.dart';
import 'package:youvideo/ui/entity/horizon.dart';

import 'provider.dart';

class EntityPage extends StatelessWidget {
  final int id;

  const EntityPage({Key? key, required this.id}) : super(key: key);

  static Launch(BuildContext context, int? id) {
    if (id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EntityPage(
                  id: id,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EntityProvider>(
        create: (_) => EntityProvider(id: id),
        child: Consumer<EntityProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ViewportSelector(
            verticalChild: EntityHorizonPage(),
            horizonChild: EntityHorizonPage(),
          );
        }));
  }
}
