import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/helpers/AppConfig.dart';

import '../helpers/Endpoints.dart';
import '../models/Photo.dart';
import '../utils/color.dart';

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  String getFilePath(BuildContext context)=>Provider.of<AppConfig>(context, listen: false).appDocumentDirectory +
      "/" +
      Endpoints.getImageFilePath(Endpoints.photoSavePath, photo.id);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder(
      future: File(getFilePath(context)).exists(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot)=>Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 5),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(25),
            image: snapshot.hasData ?
                DecorationImage(
                image: (snapshot.data==true ?
                FileImage(File(getFilePath(context)
                )) : NetworkImage(photo.url)) as ImageProvider,
                fit: BoxFit.cover) : null,
          color: snapshot.hasData ? null : randColor(Random(photo.id))
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "id : " + photo.id.toString(),
            style: theme.textTheme.headline4?.copyWith(
                color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
