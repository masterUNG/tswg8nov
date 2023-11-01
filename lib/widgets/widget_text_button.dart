// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checkofficer/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: pressFunc, child: WidgetText(data: label));
  }
}
