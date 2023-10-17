
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bashtil/models/app_helper.dart';
import 'package:bashtil/utilities/app_colors.dart';

 import 'package:sentry_flutter/sentry_flutter.dart';
 import 'my_app.dart';
import 'ui/home/homePage.dart';

Future<void> main() async {

  // HttpOverrides.global = MyHttpOverrides();


  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await initAppModel();
  await initMyApp();

}

Future<void> initAppModel() async {
  await AppHelper().init();
  AppHelper().updateSystemUiOverLayStyle(accentColor, Brightness.dark);
  return Future.value();
}

Future<void> initMyApp() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);



  await SentryFlutter.init(
        (options) {
      options.dsn =
      'https://707885e353034986a8e6a43398ad7d60@o1095166.ingest.sentry.io/4504435089473536';

      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp( MyApp(
        startWidget: homePageWidget())),
  );
}
