import 'package:flutter/material.dart';

class RowExpanded extends StatelessWidget {
  final List<Widget> listWidget;
  final List<int> listFlex;
  const RowExpanded(
      {super.key, required this.listWidget, required this.listFlex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < listFlex.length; i++)
          Expanded(flex: listFlex[i], child: listWidget[i])
      ],
    );
  }
}
