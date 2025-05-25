import 'package:bazario/app/app_colors.dart';
import 'package:bazario/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_routs.dart';
import 'controller_binder.dart';

class Bazario extends StatefulWidget {
  const Bazario({super.key});

  @override
  State<Bazario> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<Bazario> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
          colorSchemeSeed: AppColors.themeColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.themeColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.themeColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.themeColor),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
              )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                foregroundColor: Colors.white,
                backgroundColor: AppColors.themeColor
            ),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white
          )
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('bn')],
      initialBinding: ControllerBinder(),
    );
  }
}