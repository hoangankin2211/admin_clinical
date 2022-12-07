import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../models/invoice.dart';

class DialogInvoiceView extends StatelessWidget {
  final Invoice invoice;
  const DialogInvoiceView({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> lColor1 = [
      Colors.blue.withOpacity(0.2),
      Colors.red.withOpacity(0.2),
      Colors.green.withOpacity(0.2),
    ];
    List<Color> lColor2 = [
      Colors.blue,
      Colors.red,
      Colors.green,
    ];
    List<String> listStatus = ["Cancelled", "Overdue", "Paid"];
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 600,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'View Invoice',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: lColor1[invoice.status]),
                  child: Text(
                    listStatus[invoice.status],
                    style: TextStyle(
                        color: lColor2[invoice.status],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 0.5),
            const SizedBox(height: 10.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(invoice.thumb),
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 7.0)
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _dataInvoiceItem(header: "ID", title: invoice.id),
                        const SizedBox(height: 10.0),
                        _dataInvoiceItem(
                            header: "Create Time",
                            title: DateFormat()
                                .add_yMMMEd()
                                .format(invoice.createTime)),
                        const SizedBox(height: 10.0),
                        _dataInvoiceItem(
                            header: "Category", title: invoice.category),
                        const SizedBox(height: 10.0),
                        _dataInvoiceItem(header: "Title", title: invoice.title),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _dataInvoiceItem({required String header, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$header: ',
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 0.7, color: Colors.grey)),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 19.0,
            ),
          ),
        ),
      ],
    );
  }
}
