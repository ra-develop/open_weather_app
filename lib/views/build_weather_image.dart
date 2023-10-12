import 'package:flutter/material.dart';

import '../models/data/CurrentWeatherData.dart';
import '../services/core/config.dart';
import '../services/utils/common_image_provider.dart';

class BuildWeatherImage extends StatelessWidget {
  const BuildWeatherImage({
    super.key,
    required this.context,
    this.currentWeatherData,
    required this.imageSize,
  });

  final BuildContext context;
  final CurrentWeatherData? currentWeatherData;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    // final imageSize = MediaQuery.of(context).size.width / 1.5;
    return Center(
      child: Image(
          width: imageSize,
          height: imageSize,
          image: commonImageProvider(currentWeatherData != null
              ? "${Config.getImageBaseUrl}${currentWeatherData?.weather?.first.icon}@2x.png"
              : ""),
          fit: BoxFit.cover),
    );
  }
}
