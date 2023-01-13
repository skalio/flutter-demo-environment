import 'package:environment_demo/environment.dart';
import 'package:flutter/material.dart';

/// Widget for draw banner
class TestBanner extends StatelessWidget {
  final Widget? child;

  const TestBanner({
    Key? key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!Environment.isTest) {
      //When no running in test environment
      //just return the child without test banner.
      return child!;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        color: Colors.blue,
        message: "TEST",
        location: BannerLocation.topStart,
        child: child,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12.0 * 0.85,
          fontWeight: FontWeight.w900,
          height: 1.0,
        ),
      ),
    );
  }
}
