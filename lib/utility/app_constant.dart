import 'package:flutter/material.dart';

class AppConstant {
  static var apiReadAllGurests = <String>[
    'https://tswg.site/app/getAllGuest.php',
    'https://tswg.site/app/getAllGuestHome2.php',
  ];

  static var apiInsertGuests = <String>[
    'https://tswg.site/app/insertGuest.php?isAdd=true&nameAndSur=',
    'https://tswg.site/app/insertGuestHome2.php?isAdd=true&nameAndSur=',
  ];

  static var apiEditCheckOuts = <String>[
    'https://tswg.site/app/editCheckOutWhereId.php?isAdd=true&id=',
    'https://tswg.site/app/editCheckOutWhereIdHome2.php?isAdd=true&id=',
  ];

  static var apiGetGuests = <String>[
    'https://tswg.site/app/getGuestWhereId.php?isAdd=true&id=',
    'https://tswg.site/app/getGuestWhereIdHome2.php?isAdd=true&id=',
  ];

  //เปลี่ยน amountLoad คือจำนวนในการ load แต่ละครั้ง
  static int amountLoad = 5;

  static Color bgColor = const Color.fromARGB(255, 96, 22, 215);

  BoxDecoration borderBox() => BoxDecoration(
      border: Border.all(), borderRadius: BorderRadius.circular(4));

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
  TextStyle h4Style({double? size, Color? color, FontWeight? fontWeight}) =>
      TextStyle(
          fontSize: size ?? 8,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal);
}
