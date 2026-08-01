import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper around [url_launcher], centralizing how external links
/// (LinkedIn, GitHub, email) are opened and how failures are reported.
/// Callers get a simple bool back instead of dealing with [Uri] parsing
/// or [launchUrl] failure modes themselves.
class ExternalLinkLauncher {
  /// Opens [url] in the appropriate external app (browser for http(s)
  /// links). Returns true if a launch was attempted successfully,
  /// false if no app on the device could handle it.
  Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) return false;
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Opens the device's default email app with [address] pre-filled as
  /// the recipient, via a `mailto:` URI.
  Future<bool> openEmail(String address) async {
    final uri = Uri(scheme: 'mailto', path: address);
    if (!await canLaunchUrl(uri)) return false;
    return launchUrl(uri);
  }
}