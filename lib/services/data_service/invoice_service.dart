import 'dart:convert';

import 'package:admin_clinical/models/invoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_link.dart';
import 'data_service.dart';

class InvoiceService {
  InvoiceService._privateConstructor();
  static final InvoiceService instance = InvoiceService._privateConstructor();
  RxList<Invoice> listInvoice = <Invoice>[].obs;
  Future<void> fetchAllDataInvoice() async {
    print('fetch all data invoice is called');
    try {
      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/invoice/get_all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        listInvoice.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          listInvoice.add(Invoice.fromMap(map));
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print("Fetch data is error: $e");
    } finally {}
  }

  Future<Invoice?> addInvoiceMedicine(BuildContext context,
      {required String thumb,
      required double amount,
      required int status,
      required String title,
      required String medicineId,
      required String category}) async {
    print('add invoice medicine is called');
    Invoice? result;
    try {
      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/invoice/add_invoice_medicine'),
        body: jsonEncode(
          {
            'thumb': thumb,
            'amount': amount,
            'status': status,
            'createTime': DateTime.now().millisecondsSinceEpoch,
            'title': title,
            'medicineId': medicineId,
            'category': category,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }
}
