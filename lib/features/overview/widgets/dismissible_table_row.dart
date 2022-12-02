import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DismissibleTableRow extends StatelessWidget {
  const DismissibleTableRow(
      {super.key,
      required this.id,
      required this.remove,
      required this.child,
      required this.isTitleRow,
      required this.yesHandleSelection});
  final String id;
  final Function() yesHandleSelection;
  final Function(String) remove;
  final Widget child;
  final bool isTitleRow;
  @override
  Widget build(BuildContext context) {
    return isTitleRow
        ? SizedBox(child: child)
        : Dismissible(
            key: ValueKey(id),
            background: Container(
              margin: const EdgeInsets.all(7),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Theme.of(context).errorColor,
              ),
              child: const Icon(
                Icons.delete,
                size: 45,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              remove(id);
            },
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) {
              bool isDelete = false;
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    title: const Text('Are you sure ?'),
                    content: const Text(
                        'Do you want to remove the patient from the list ? '),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          isDelete = true;
                          Get.back();
                          await yesHandleSelection();
                        },
                        child: const Text('YES'),
                      ),
                      TextButton(
                        onPressed: () {
                          isDelete = false;
                          Get.back();
                        },
                        child: const Text('NO'),
                      ),
                    ],
                  );
                },
              ).then((value) async {
                return isDelete;
              });
            },
            child: child,
          );
  }
}
