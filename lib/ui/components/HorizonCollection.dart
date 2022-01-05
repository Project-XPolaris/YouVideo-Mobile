import 'package:flutter/material.dart';

class HorizonCollection extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Function()? onMore;
  final TextStyle? titleStyle;
  HorizonCollection({required this.children,required this.title,this.onMore,this.titleStyle = const TextStyle(fontWeight: FontWeight.w600)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,style: titleStyle),
                onMore != null ? GestureDetector(
                  child: Text(
                    "more",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: onMore,
                ) : Container()
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ...children
              ],
            ),
          )
        ],
      ),
    );
  }
}
