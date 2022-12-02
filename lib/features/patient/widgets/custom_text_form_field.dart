import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.title,
    this.maxLine,
    this.trailingIcon,
    this.hint,
    this.prefixWidget,
    this.width,
    this.hintStyle,
    this.borderSide,
    this.isPasswordField,
    this.controller,
    this.validator,
  });
  final String? title;
  final double? width;
  final int? maxLine;
  final BorderSide? borderSide;
  final String? hint;
  final Widget? trailingIcon;
  final Widget? prefixWidget;
  final TextStyle? hintStyle;
  final bool? isPasswordField;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: isObscure,
        maxLines: widget.maxLine,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.title,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          hintText: widget.hint,
          hintStyle: widget.hintStyle ??
              TextStyle(
                  color: Colors.grey[350]!,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: AppDecoration.primaryRadiusBorder,
            borderSide: widget.borderSide ??
                BorderSide(color: Colors.grey[350]!, width: 0.4),
          ),
          suffixIcon: SizedBox(
            height: 50,
            width: 50,
            child: InkWell(
              onTap: () {
                if (widget.isPasswordField ?? false) {
                  setState(() {
                    isObscure = !isObscure;
                  });
                }
              },
              child: widget.trailingIcon,
            ),
          ),
          prefixIcon: widget.prefixWidget,
        ),
      ),
    );
  }
}
