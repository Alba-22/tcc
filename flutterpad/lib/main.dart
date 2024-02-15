import 'package:flutter/material.dart';
import 'package:flutterpad/app/infra/datasources/isar/isar_datasource.dart';

import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatasource.init();
  runApp(const AppWidget());
}
