import 'package:url_launcher/url_launcher.dart' as url_launcher;

class AssetsName {
  static const baseRoute = "assets";
  // Icons
  static const ic = "/icon";
  static const icLogo = "$baseRoute$ic/icon.png";
  // Illustration Assets
  static const ill = "/illustration";
  static const ill3DKaaba = "$baseRoute$ill/3D-Kaaba.png";
  static const illReadTheQuran = "$baseRoute$ill/01-readTheQuran.png";
  static const illMuslimZakat = "$baseRoute$ill/02-muslimZakat.png";
  static const illMuslimahPray = "$baseRoute$ill/03-muslimahPray.png";
  static const illMuslimGive = "$baseRoute$ill/04-muslimGive.png";
  static const illMuslimPray = "$baseRoute$ill/05-muslimPray.png";
}

class Helper {
  static Future<void> launchURL(String url) async {
    await url_launcher.launch(url);
    return;
  }
}