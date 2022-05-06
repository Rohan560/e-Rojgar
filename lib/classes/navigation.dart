import 'package:flutter/material.dart';

class Navigation {
  IconData icon;
  Widget Function(BuildContext)? builder;
  Navigation({required this.icon, this.builder});
}
