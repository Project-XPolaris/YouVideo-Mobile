import 'package:flutter/material.dart';
import 'package:youui/components/TitleSection.dart';

import '../../api/meta.dart';
import '../videos/wrap.dart';

class MetasSection extends StatelessWidget {
  final List<Meta> metas;

  const MetasSection({Key? key, this.metas = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSection(
      title: "Meta",
      child: Wrap(
        children: [
          ...metas.map((meta) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                child: ActionChip(
                  label: Text(meta.value ?? ""),
                  onPressed: () {
                    VideosPageWrap.launchWithMetaVideo(context, meta);
                  },
                  avatar: CircleAvatar(
                    child: Text("#"),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
