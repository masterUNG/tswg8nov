// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:checkofficer/utility/app_constant.dart';
import 'package:flutter/material.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    Key? key,
    required this.file,
    this.size,
  }) : super(key: key);

  final File file;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: AppConstant().borderBox(),
      margin: const EdgeInsets.all(4),
      width: size,
      height: size,
      child: Image.file(
        file,
        fit: BoxFit.cover,
      ),
    );
  }
}
