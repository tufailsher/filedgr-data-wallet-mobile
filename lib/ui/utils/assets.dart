import 'package:file_dgr/ui/utils/utils.dart';
import 'package:flutter/material.dart';

/// Usage:
///
/// The image file is located at *images/path/to/image.png*.
///
/// 1. Image has no dark mode variant.
///
///     Assets.image(context, 'path/to/image.png', isDarkModeAware: false);
///
/// 2. Image has a dark mode variant. Dark mode variant should be placed at
/// *images/dark/path/to/image_dark.png*.
///
///     Assets.image(context, 'path/to/image.png');
///
class Assets {
  /// Returns the AssetImage based on the current app's theme mode.
  static AssetImage image(
    BuildContext context,
    String imagePath, {
    bool isDarkModeAware = true,
  }) {
    final isDarkMode = isDarkModeAware &&
        // SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
        Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      final splits = imagePath.splitAfterLast('.');
      if (splits.length == 2) {
        final newImagePath = '${splits[0]}_dark.${splits[1]}';
        return AssetImage('$_imagesFolder/dark/$newImagePath');
      } else {
        return AssetImage('$_imagesFolder/$imagePath');
      }
    } else {
      return AssetImage('$_imagesFolder/$imagePath');
    }
  }

  static const _imagesFolder = 'images';
}
