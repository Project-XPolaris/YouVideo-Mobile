import 'package:flutter/material.dart';
import 'package:youui/components/TitleSection.dart';

import '../../api/tag.dart';
import '../videos/wrap.dart';
import 'AddTagBottomDialog.dart';

class TagsSection extends StatelessWidget {
  final List<Tag> tags;
  final Function(Tag)? onRemove;
  final Function(String)? onAdd;
  const TagsSection({Key? key,this.tags = const [],this.onRemove,this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSection(
      title: "Tags",
      child: Wrap(
        children: [
          ...tags.map((tag) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                child: ActionChip(
                  label: Text(tag.name),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VideosPageWrap(
                                title: tag.name,
                                filter: {
                                  "tag": tag.id.toString()
                                },
                              )),
                    );
                  },
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    child: Text("#",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),
                  ),
                ),
                onLongPress: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(children: [
                          ListTile(
                            leading: Icon(Icons.delete_rounded),
                            title: Text("Remove tag"),
                            onTap: () {
                                onRemove?.call(tag);
                                Navigator.pop(context);
                            },
                          ),
                          Container(
                            height: 16,
                          )
                        ]);
                      });
                },
              ),
            );
          }).toList(),
          ActionChip(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            label: Text("Add"),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddTagBottomDialog(
                      onCreate: (text) {
                        onAdd?.call(text);
                        Navigator.pop(context);
                      },
                    );
                  },
                  isScrollControlled: true,
                  useRootNavigator: true);
            },
            avatar: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(Icons.add_rounded,color: Theme.of(context).colorScheme.onPrimaryContainer,size: 24,),
            ),
          )
        ],
      ),
    );
  }
}
