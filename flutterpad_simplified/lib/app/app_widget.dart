import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/presentation/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterPad",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primary),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const HomePage(),
    );
  }
}
