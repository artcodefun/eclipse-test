import 'dart:math';

import 'package:flutter/material.dart';

import '../models/Photo.dart';
import '../utils/color.dart';

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 5),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(image: NetworkImage(photo.url), fit: BoxFit.cover)
        ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "id : " + photo.id.toString(),
          style: theme.textTheme.headline4?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            photo.title,
            style: theme.textTheme.headline5?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }
}
