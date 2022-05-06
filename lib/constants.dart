// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rohan_erojgar/helpers.dart';

const primaryColorBG = Color(0xff092769);

final MaterialColor primaryColorSwtach = createMaterialColor(primaryColorBG);

late GlobalKey<NavigatorState> navigatorKey;

OutlineInputBorder inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
  borderSide: BorderSide(
    color: Color(0xff092769),
    width: 1,
  ),
);

const kUnitPadding = 6.0;

const kTopContentMargin = 25.0;

final kJobCategories = [
  'Civil Engineering',
  'Management',
  'IT',
  'Reception',
  'App Development'
];

final kJobTypes = ['Full time', 'Part time'];

const kFreeJobPosts = 2;

const String kAPIURL = "http://192.168.137.1:3000";
