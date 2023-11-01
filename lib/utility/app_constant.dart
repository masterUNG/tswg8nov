import 'package:flutter/material.dart';

class AppConstant {
  static Color bgColor = const Color.fromARGB(255, 96, 22, 215);

  BoxDecoration borderBox() => BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4)
      );

  BoxDecoration colorBox() => BoxDecoration(color: bgColor);

  BoxDecoration gradienBox() => BoxDecoration(
        gradient: RadialGradient(
            colors: [Colors.white, bgColor],
            radius: 0.8,
            center: const Alignment(-0.5, -0.5)),
      );

  BoxDecoration imageBox() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      );

  TextStyle h1Style({double? size, Color? color, FontWeight? fontWeight}) =>
      TextStyle(
          fontSize: size ?? 36,
          color: color,
          fontWeight: fontWeight ?? FontWeight.bold);

  TextStyle h2Style({double? size, Color? color, FontWeight? fontWeight}) =>
      TextStyle(
          fontSize: size ?? 22,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w700);

  TextStyle h3Style({double? size, Color? color, FontWeight? fontWeight}) =>
      TextStyle(
          fontSize: size ?? 14,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal);
}
