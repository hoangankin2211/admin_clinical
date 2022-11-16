import 'package:flutter/material.dart';

import '../app_decoration.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final int maxLines;
  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.labelText,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool checkShow = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: checkShow,
      controller: widget.controller,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: Colors.grey[350]!,
            fontWeight: FontWeight.w500,
            fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: AppDecoration.primaryRadiusBorder,
          borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              checkShow = !checkShow;
            });
          },
          child: Icon(
            (checkShow) ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}
