import 'package:flutter/material.dart';
import '../view/home_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => const HomePage(),
  };
}
