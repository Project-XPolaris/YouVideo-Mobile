import 'package:flutter/material.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/ui/components/VideoCover.dart';
import 'package:youvideo/util/listview.dart';

class HistoryListHorizon extends StatelessWidget {
  final Function onLoadMore;
  final List<History> historyList;
  final Function(History)? onItemClick;
  const HistoryListHorizon({Key? key,required this.onLoadMore,required this.historyList,this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var crossAxisCount = width ~/ 200;
    var controller = createLoadMoreController(onLoadMore);
    return GridView.count(
      controller: controller,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: crossAxisCount,
      children: <Widget>[
        ...historyList.map((e) {
          return Container(
            child: Column(
              children: [
                Expanded(child: VideoCover(
                  coverUrl: e.getCoverUrl(),
                  onTap: (){
                    this.onItemClick?.call(e);
                  },
                  borderRadius: 8,
                  width: 250,
                  height: 150,
                )),
                Container(
                  child: Text(e.name,style: TextStyle(color: Colors.white),maxLines: 3,),
                  height: 64,
                )
              ],
            ),
          );
        })
        ,
      ],
    );
  }
}
