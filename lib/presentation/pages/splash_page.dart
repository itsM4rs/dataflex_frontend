import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadingText('Loading...'),
    );
  }
}
