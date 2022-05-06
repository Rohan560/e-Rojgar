// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/screens/splash.dart';
import 'controllers/search_controller.dart';
import 'controllers/user_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => SearchController()),
      ],
      child: KhaltiScope(
          publicKey: "test_public_key_809fcbee00b24403b2fc46f6c529949d",
          builder: (context, navKey) {
            navigatorKey = navKey;
            return MaterialApp(
              navigatorKey: navKey,
              debugShowCheckedModeBanner: false,
              title: 'eRojgar',
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                 KhaltiLocalizations.delegate,
              ],
              theme: ThemeData(
                primarySwatch: primaryColorSwtach,
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: inputBorder,
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  errorBorder: inputBorder,
                  disabledBorder: inputBorder,
                  focusedErrorBorder: inputBorder,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.symmetric(
                        vertical: kUnitPadding,
                        horizontal: kUnitPadding * 2,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    textStyle: MaterialStateProperty.resolveWith(
                      (states) => TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                textTheme: TextTheme().apply(
                    bodyColor: primaryColorBG, displayColor: primaryColorBG),
              ),
              home: const SplashScreen(),
            );
          }),
    );
  }
}
