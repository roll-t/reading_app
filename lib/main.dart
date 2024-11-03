import 'package:flutter/material.dart';
import 'package:reading_app/app_config.dart';

import 'app.dart';

void main() async {
  await appConfig();
  runApp(const App());
}
