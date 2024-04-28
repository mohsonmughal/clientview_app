import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    // required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  static int normalWidth = 650;

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < normalWidth;

  static bool isTablet(BuildContext context) =>
      //1100..Tablet
      MediaQuery.of(context).size.width < 1300 &&
      MediaQuery.of(context).size.width >= normalWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width it less then 1100 and more then 600 we consider it as tablet
        if (constraints.maxWidth >= normalWidth) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
