import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';

import '../core/config.dart';

ImageProvider commonImageProvider([String? imageUrl = ""]) {
  ImageProvider resultImageProvider;
  final String imageUrlString = imageUrl ?? "";
  try {
    if (imageUrlString == "") {
      resultImageProvider = AssetImage(Config.defaultIcon);
    } else if (imageUrlString.startsWith("http")) {
      resultImageProvider = NetworkImage(
        imageUrlString,
      );
    } else if (imageUrlString.contains("asset")) {
      resultImageProvider = AssetImage(imageUrlString);
    } else {
      if (File(imageUrlString).existsSync()) {
        resultImageProvider = FileImage(
          File(imageUrlString),
        );
      } else {
        debugPrint(
            "commonImageProvider: unable load image by path: $imageUrlString");
        debugPrint("commonImageProvider: try to load default image");
        return AssetImage(Config.defaultIcon);
      }
    }
  } on Exception catch (e) {
    debugPrint(
        "commonImageProvider: unable load image by path: $imageUrlString");
    debugPrint("commonImageProvider: try to load default image");
    debugPrint("commonImageProvider: by Exception: $e");
    return AssetImage(Config.defaultIcon);
  }

  return FadeInImage(
    image: resultImageProvider,
    placeholder: AssetImage(Config.defaultIcon),
    imageErrorBuilder: _onErrorBuilder,
    placeholderFit: BoxFit.scaleDown,
  ).image;
}

Widget _onErrorBuilder(
    BuildContext context, Object exception, StackTrace? stackTrace) {
  developer.log(exception.toString(),
      name: "commonImageProvider", stackTrace: stackTrace);
  return const Text('ð¢');
}
