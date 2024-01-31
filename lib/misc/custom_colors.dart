import 'package:flutter/material.dart';

class CustomColors extends MaterialColor {
  final candlelight = MaterialColor(
    const Color(0xFFFFFF00).value,
    const <int, Color>{
      50: Color(0xfffcfcea),
      100: Color(0xfffaf8c7),
      200: Color(0xfff6f192),
      300: Color(0xfff0e154),
      400: Color(0xffe9ce20),
      500: Color(0xffdab818),
      600: Color(0xffbc9012),
      700: Color(0xff966912),
      800: Color(0xff7c5317),
      900: Color(0xff6a4419),
      950: Color(0xff3e240a),
    },
  );

  CustomColors(super.primary, super.swatch);
}
