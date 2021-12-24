import 'package:flutter/material.dart';
import 'package:youui/components/filter.dart';

const OrderFilterKeys = [
  "id asc",
  "id desc",
  "name asc",
  "name desc",
  "created_at asc",
  "created_at desc"
];

class VideoFilter {
  String order;
  bool random;
  VideoFilter({required this.order, this.random = false});
}

class VideoFilterView extends StatefulWidget {
  final VideoFilter filter;
  final Function(VideoFilter filter) onChange;

  VideoFilterView({required this.filter, required this.onChange});

  @override
  _VideoFilterViewState createState() =>
      _VideoFilterViewState(order: filter.order, random: filter.random);
}

class _VideoFilterViewState extends State<VideoFilterView> {
  String order;

  _VideoFilterViewState({required this.order, required this.random});

  bool random;

  @override
  Widget build(BuildContext context) {
    List<String> getRandomCheck() {
      return random ? ["random"] : [];
    }

    return FilterView(
        padding: EdgeInsets.only(left: 16, right: 16),
        backgroundColor: Colors.black,
        headerBackgroundColor: const Color(0xFF303030),
        children: [
          SigleSelectFilterView(
              value: order,
              selectedColor: Colors.red,
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
              selectedColor: Colors.red,
              onValueChange: (values) {
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
