import 'package:flutter/material.dart';

const OrderFilterKeys = [
  "id asc", "id desc", "name asc", "name desc", "created_at asc", "created_at desc"
];

class VideoFilter {
  String order;
  VideoFilter({this.order});
}

class VideoFilterView extends StatefulWidget {
  final VideoFilter filter;
  final Function(VideoFilter filter) onChange;
  VideoFilterView({this.filter,this.onChange});

  @override
  _VideoFilterViewState createState() => _VideoFilterViewState(order: filter.order);
}

class _VideoFilterViewState extends State<VideoFilterView> {
  String order;
  _VideoFilterViewState({this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFF303030),
            child: Text(
              "Filter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text("Order", style: TextStyle(color: Colors.white70),),
          ),
          Wrap(
            children: [
              ...OrderFilterKeys.map((key) {

                return Padding(padding: EdgeInsets.only(left: 4,right: 4),
                  child: FilterChip(label: Text(key),
                    onSelected: (selected) {
                      widget.filter.order = key;
                      widget.onChange(widget.filter);
                      setState(() {
                        order = key;
                      });
                    },
                    selected: order == key,
                    selectedColor: Colors.red,
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
