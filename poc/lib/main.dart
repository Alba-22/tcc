import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/factory/android_dialog.dart';
import 'package:poc_tcc/dialog/approaches/factory/ios_dialog.dart';
import 'package:poc_tcc/home_page.dart';

import 'dialog/approaches/factory/base_dialog.dart';

late final BaseDialog dialog;

void main() {
  dialog = _configureDialog();
  runApp(const MyApp());
}

BaseDialog _configureDialog() {
  if (Platform.isIOS) {
    return IosDialog();
  } else {
    return AndroidDialog();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
        ),
      ),
      home: const HomePage(),
    );
  }
}
