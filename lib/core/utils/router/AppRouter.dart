import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static goTOWidget(Widget widget) {
    navigationKey.currentState!.push(MaterialPageRoute(builder: (x) {
      return widget;
    }));
  }

  static goTOScreen(String routeName, [dynamic arguments]) {
    navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static goBackTOScreen() {
    navigationKey.currentState!.pop();
  }

  static goTOScreenAndReplace(String routeName) {
    navigationKey.currentState!.pushReplacementNamed(routeName);
  }

  static void showCustomDialoug(String message, String title) {
    showDialog(
        context: navigationKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
          );
        });
  }
}
