import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/pages/AlbumPage.dart';

import '../models/Album.dart';
import '../utils/color.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => AlbumPage(albumId: album.id ,appBarColor: randColor(Random(album.id)),))),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 5),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(25),
            color: randColor(Random(album.id))),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            album.title,
            style: theme.textTheme.headline4?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
        ]),
      ),
    );
  }
}
