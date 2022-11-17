import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final List<Widget> widgets;
  final bool? checkHeader;
  const ListItem({super.key, required this.widgets, this.checkHeader});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: checkHeader == null
          ? Row(
              children: [
                ...widgets.map((e) => Expanded(child: e)),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 1, child: widgets[0]),
                for (int i = 1; i < widgets.length; i++)
                  Expanded(flex: 3, child: widgets[i])
              ],
            ),
    );
  }
}

class ListItem1 extends StatelessWidget {
  final List<Widget> widgets;
  final bool? checkHeader;
  const ListItem1({super.key, required this.widgets, this.checkHeader});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: checkHeader == null
          ? Row(
              children: [
                ...widgets.map((e) => Expanded(child: e)),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 1, child: widgets[0]),
                for (int i = 1; i < widgets.length; i++)
                  Expanded(flex: 3, child: widgets[i])
              ],
            ),
    );
  }
}
