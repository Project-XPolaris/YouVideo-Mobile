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

List<String> getYearFilter() {
  List<String> years = [];
  for (int i = DateTime.now().year; i >= DateTime.now().year - 25; i--) {
    years.add(i.toString());
  }
  return years;
}

class VideoFilter {
  String order;
  bool random;
  String? year;

  VideoFilter({required this.order, this.random = false, this.year});
}

class VideoFilterView extends StatefulWidget {
  final VideoFilter filter;
  final Function(VideoFilter filter) onChange;

  VideoFilterView({required this.filter, required this.onChange});

  @override
  _VideoFilterViewState createState() => _VideoFilterViewState(
      order: filter.order, random: filter.random, year: filter.year);
}

class _VideoFilterViewState extends State<VideoFilterView> {
  String order;
  String? year;

  _VideoFilterViewState({required this.order, required this.random, this.year});

  bool random;

  @override
  Widget build(BuildContext context) {
    List<String> getRandomCheck() {
      return random ? ["random"] : [];
    }

    return FilterView(
        padding: EdgeInsets.only(left: 16, right: 16),
        children: [
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
              onValueChange: (option,isChecked,values) {
                bool isRandom = values.contains("random");
                widget.filter.random = isRandom;
                widget.onChange(widget.filter);
                setState(() {
                  random = isRandom;
                });
              }),
          SigleSelectFilterView(
              value: year,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              options: [
                ...getYearFilter().map((key) {
                  return SelectOption(label: key, key: key);
                })
              ],
              onSelectChange: (option) {
                if (option.key == year) {
                  widget.filter.year = null;
                } else {
                  widget.filter.year = option.key;
                }
                setState(() {
                  year = widget.filter.year;
                });
                widget.onChange(widget.filter);
              },
              title: "years"),
        ]);
  }
}
