import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutterpad/app/infra/datasources/isar/isar_datasource.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatasource.init();
  initializeDateFormatting("pt-BR", "/");
  runApp(
    DevicePreview(
      enabled: const bool.fromEnvironment("PREVIEW_ENABLED"),
      builder: (context) => const AppWidget(),
    ),
  );
}
