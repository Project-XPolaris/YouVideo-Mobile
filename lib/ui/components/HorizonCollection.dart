import 'package:flutter/material.dart';

class HorizonCollection extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Function()? onMore;
  HorizonCollection({required this.children,required this.title,this.onMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style: TextStyle(fontWeight: FontWeight.w600),),
                  onMore != null ? TextButton(
                    child: Text(
                      "more",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: onMore,
                  ) : Container()
                ],
              ),
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
