import 'package:flutter/material.dart';
import 'package:youui/components/filter.dart';

const OrderFilterKeys = [
  "id asc",
  "id desc",
  "name asc",
  "name desc",
  "created_at asc",
  "created_at desc",
  "release asc",
  "release desc",
];

class EntityFilter {
  String order;
  bool random;

  EntityFilter({required this.order, this.random = false});
}

class EntityFilterView extends StatefulWidget {
  final EntityFilter filter;
  final Function(EntityFilter filter) onChange;

  EntityFilterView({required this.filter, required this.onChange});

  @override
  _EntityFilterViewState createState() =>
      _EntityFilterViewState(order: filter.order, random: filter.random);
}

class _EntityFilterViewState extends State<EntityFilterView> {
  String order;
  String? year;

  _EntityFilterViewState(
      {required this.order, required this.random, this.year});

  bool random;

  @override
  Widget build(BuildContext context) {
    List<String> getRandomCheck() {
      return random ? ["random"] : [];
    }

    return FilterView(padding: EdgeInsets.only(left: 16, right: 16), children: [
      SigleSelectFilterView(
          value: order,
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          options: [
            ...OrderFilterKeys.map((key) {
              return SelectOption(label: key, key: key);
            })
          ],
          onSelectChange: (option) {
            widget.filter.order = option.key;
            widget.onChange(widget.filter);
            setState(() {
              order = option.key;
            });
          },
          title: "order"),
      CheckChipFilterView(
          title: "other",
          options: [SelectOption(label: "Random", key: "random")],
          checked: getRandomCheck(),
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          onValueChange: (option, isChecked, values) {
            bool isRandom = values.contains("random");
            widget.filter.random = isRandom;
            widget.onChange(widget.filter);
            setState(() {
              random = isRandom;
            });
          })
    ]);
  }
}
