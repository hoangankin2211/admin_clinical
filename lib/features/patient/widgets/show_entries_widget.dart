import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

class ShowEntriesWidget extends StatelessWidget {
  ShowEntriesWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.numberOfEntries,
      required this.applyEntries,
      required this.maxEntries});
  final double height;
  final double width;
  final int numberOfEntries;
  final int maxEntries;
  final Function(int) applyEntries;

  late final TextEditingController controller =
      TextEditingController(text: numberOfEntries.toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Show',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: AppDecoration.primaryRadiusBorder,
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: height,
                  maxHeight: width,
                ),
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) => applyEntries(int.parse(value)),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (int.parse(controller.text) < maxEntries) {
                        controller.text =
                            (int.parse(controller.text) + 1).toString();
                        applyEntries(int.parse(controller.text));
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (int.parse(controller.text) > 1) {
                        controller.text =
                            (int.parse(controller.text) - 1).toString();
                        applyEntries(int.parse(controller.text));
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'entries',
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }
}
