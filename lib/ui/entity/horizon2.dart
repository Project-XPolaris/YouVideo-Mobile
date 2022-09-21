import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/entity/provider.dart';

import '../components/MetasSection.dart';
import '../components/VideosHorizonCollection.dart';
import '../video/vertical.dart';

class EntityHorizonPage extends StatelessWidget {

  const EntityHorizonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntityProvider>(context);
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.only(top: 72),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 240,
                                      height: 180,
                                      child: Cover(
                                        url: provider.coverUrl,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Text(
                                          provider.entity?.name ?? "Unknown",
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 32,
                              left: 16,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    size: 22,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        child: ListView(children: [
                          provider.infos.isNotEmpty
                              ? MetasSection(
                            metas: provider.infos,
                          )
                              : Container(),
                        ]),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        provider.entity != null
                            ? Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Container(
                            height: 180,
                            child: VideosHorizonCollection(
                              baseHeight: 120,
                              videos: provider.videos,
                              title: "Videos",
                              titleStyle:
                              TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}