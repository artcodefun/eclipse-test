import 'dart:math';

import 'package:flutter/material.dart';

import '../models/Comment.dart';
import '../utils/color.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

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
          color: randColor(Random(comment.id))),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              comment.email,
              style: theme.textTheme.headline5?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600),
            ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            comment.name,
            style: theme.textTheme.headline6?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
        ),

        Text(
          comment.body,
          style: theme.textTheme.headline6?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}
