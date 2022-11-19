import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonMouseRegion extends StatelessWidget {
  final Color color;
  final Color colorChange;
  final Widget child;
  final Function() func;
  ButtonMouseRegion(
      {super.key,
      required this.color,
      required this.colorChange,
      required this.child,
      required this.func});
  RxBool onIt = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) => onIt.value = true,
      onExit: (value) => onIt.value = false,
      child: Obx(
        () => InkWell(
          onTap: func,
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 100),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: onIt.value ? colorChange : color,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
