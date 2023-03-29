import 'package:package_info_plus/package_info_plus.dart';

/// A class that provides a way to customize the flavors at the Flutter level.
/// The package name/application id/bundle id should be specified at the native
/// platform level. This class is here to provide an easier overview for the
/// various settings a flavor has.
class FlavorSettings {
  final String baseUrl;

  /// Returns the FlavorSettings object for the current flavor configuration.
  static Future<FlavorSettings> getSettings() async {
    return await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      if (packageInfo.packageName.endsWith('.dev')) {
        return FlavorSettings._dev();
      } else if (packageInfo.packageName.endsWith('.qa')) {
        return FlavorSettings._qa();
      } else {
        return FlavorSettings._prod();
      }
    });
  }

  FlavorSettings._dev()
      : baseUrl =
            'https://bipr9tcy50.execute-api.eu-central-1.amazonaws.com/dev/api';

  FlavorSettings._qa()
      : baseUrl =
            'https://bipr9tcy50.execute-api.eu-central-1.amazonaws.com/dev/api';

  FlavorSettings._prod()
      : baseUrl =
            'https://bipr9tcy50.execute-api.eu-central-1.amazonaws.com/dev/api';
}
