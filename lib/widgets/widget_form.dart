// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.suffixWidget,
    this.obsecu,
    required this.changeFunc,
    this.labelWidget,
    this.textInputType,
  }) : super(key: key);

  final String? hint;
  final Widget? suffixWidget;
  final bool? obsecu;
  final Function(String) changeFunc;
  final Widget? labelWidget;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 45,
      child: TextFormField(keyboardType: textInputType,
        onChanged: changeFunc,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(
          label: labelWidget,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          suffixIcon: suffixWidget,
          hintText: hint,
          filled: true,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
