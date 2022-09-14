import 'package:flutter/material.dart';
import 'package:youui/components/filter.dart';

class MetaFilter {
  String? key;

  MetaFilter();
}

class MetaFilterView extends StatefulWidget {
  final MetaFilter filter;
  final Function(MetaFilter filter) onChange;
  final List<String> keys;

  const MetaFilterView(
      {Key? key,
      required this.onChange,
      required this.filter,
      required this.keys})
      : super(key: key);

  @override
  _MetaFilterViewState createState() => _MetaFilterViewState();
}

class _MetaFilterViewState extends State<MetaFilterView> {
  String? key;

  @override
  void initState() {
    super.initState();
    key = widget.filter.key;
  }

  _MetaFilterViewState();

  @override
  Widget build(BuildContext context) {
    return FilterView(
        padding: EdgeInsets.only(left: 16, right: 16),
        children: [
          SigleSelectFilterView(
              value: key,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              options: [
                ...widget.keys.map((key) {
                  return SelectOption(label: key, key: key);
                })
              ],
              onSelectChange: (option) {
                if (option.key == key) {
                  setState(() {
                    key = null;
                  });
                  widget.filter.key = null;
                } else {
                  setState(() {
                    key = option.key;
                  });
                  widget.filter.key = key;
                }
                widget.onChange(widget.filter);
              },
              title: "by key"),
        ]);
  }
}
