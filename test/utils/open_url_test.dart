import 'package:flutter_test/flutter_test.dart';
import 'package:notenschluessel/utils/utils.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockUrlLauncher extends UrlLauncherPlatform {
  @override
  LinkDelegate? get linkDelegate => throw UnimplementedError();

  @override
  Future<bool> launch(
    String url, {
    required bool useSafariVC,
    required bool useWebView,
    required bool enableJavaScript,
    required bool enableDomStorage,
    required bool universalLinksOnly,
    required Map<String, String> headers,
    String? webOnlyWindowName,
  }) {
    return Future.value(false);
  }
}

void main() {
  group('openUrl', () {
    late UrlLauncherPlatform mock;

    setUp(() {
      mock = MockUrlLauncher();
    });

    test('correctly throws error on invalid url', () {
      const url2 = 'https://invalid';
      UrlLauncherPlatform.instance = mock;
      expectLater(openUrl(url2), throwsException);
    });
  });
}
