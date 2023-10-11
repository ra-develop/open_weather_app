import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';

import '../core/config.dart';

ImageProvider commonImageProvider([String? imageUrl = ""]) {
  ImageProvider resultImageProvider;
  String _imageUrl = imageUrl ?? "";
  try {
    if (_imageUrl == "") {
      resultImageProvider = AssetImage(Config.defaultIcon);
    } else if (_imageUrl.startsWith("http")) {
      resultImageProvider = NetworkImage(
        _imageUrl,
      );
    } else if (_imageUrl.contains("asset")) {
      resultImageProvider = AssetImage(_imageUrl);
    } else {
      if (File(_imageUrl).existsSync()) {
        resultImageProvider = FileImage(
          File(_imageUrl),
        );
      } else {
        debugPrint("commonImageProvider: unable load image by path: $imageUrl");
        debugPrint("commonImageProvider: try to load default image");
        return AssetImage(Config.defaultIcon);
      }
    }
  } on Exception catch (e) {
    debugPrint("commonImageProvider: unable load image by path: $imageUrl");
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
