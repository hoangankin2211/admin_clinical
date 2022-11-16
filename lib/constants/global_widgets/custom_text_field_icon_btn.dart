import 'package:flutter/material.dart';

import '../app_decoration.dart';

class CustomTextFieldIconBtn extends StatelessWidget {
  const CustomTextFieldIconBtn({
    super.key,
    required this.title,
    this.maxLine,
    this.trailingIcon,
    this.hint,
    this.prefixWidget,
    required this.width,
    required this.callBack,
  });
  final String title;
  final double width;
  final int? maxLine;
  final String? hint;
  final Icon? trailingIcon;
  final Widget? prefixWidget;
  final VoidCallback callBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: maxLine,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey[350]!,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: AppDecoration.primaryRadiusBorder,
            borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
          ),
          suffixIcon: InkWell(onTap: callBack, child: trailingIcon),
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}
