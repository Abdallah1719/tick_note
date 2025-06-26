import 'package:flutter/material.dart';

class RoutesMethods {
  //  only (push)
  static void pushNavigate(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  //  only (pushReplacement)
  static void replacementNavigate(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  //  only (pushAndRemoveUntil)
  static void pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  // only (pop)
  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // push with (arguments)
  static void pushNamedWithArgs<T>({
    required BuildContext context,
    required String routeName,
    T? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  //  استرجاع البيانات في الصفحة الجديدة
  static T? getArgs<T>(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is T) {
      return arguments;
    }
    return null;
  }

  // push with cubit
  static void pushWithCubit({
    required BuildContext context,
    required String routeName,
    required Widget screen,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  // replace with arguments
  static void replaceWithArgs<T>({
    required BuildContext context,
    required String routeName,
    T? arguments,
  }) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
}
