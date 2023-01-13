import 'package:AirmineStudy/screens/home/web/homeweb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:AirmineStudy/provider/theme_provider.dart';

import 'package:AirmineStudy/screens/home/mobile/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airmine',
      theme: MyTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: kIsWeb ? const HomeMainWeb() : const HomePageMainMobile(),
    );
  }
}
