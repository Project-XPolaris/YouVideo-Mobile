import 'package:flutter/material.dart';
import 'package:youui/components/TitleSection.dart';
import 'package:youvideo/ui/components/VideoPlayView.dart';

import '../../api/file.dart';

class FilesSection extends StatelessWidget {
  final List<File> files;

  const FilesSection({Key? key, this.files = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSection(
        title: "Files",
        child: Column(
          children: [
            ...files.map((e) => Column(
                  children: [
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(maxWidth: 1200),
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            builder: (ctx) {
                              return VideoPlayView(
                                file: e,
                              );
                            });
                      },
                      title: Text(e.name),
                      subtitle: Text(e.getDescriptionText()),
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(
                          Icons.videocam_rounded,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      trailing: Text(e.getDurationText()),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ))
          ],
        ));
  }
}
