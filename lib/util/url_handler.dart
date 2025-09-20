import 'package:url_launcher/url_launcher.dart';

// this class opens a given URL in an external application, like the phone's web browser
abstract class UrlHandler {
  void openUrl(String uri);
}

class UrlLauncher extends UrlHandler {
  @override
  void openUrl(String uri) {
    launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
  }
}
