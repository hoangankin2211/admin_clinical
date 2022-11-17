import 'package:flutter/material.dart';

class HeaderListItem extends StatelessWidget {
  final List<String> titles;
  final bool? checkHeader;
  const HeaderListItem({super.key, required this.titles, this.checkHeader});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(15.0),
      child: checkHeader == null
          ? Row(
              children: [
                ...titles.map(
                  (e) => Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Row(children: [
              for (int i = 0; i < titles.length; i++)
                Expanded(
                  flex: i == 0 ? 1 : 3,
                  child: Text(
                    titles[i],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ]),
    );
  }
}
