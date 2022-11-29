import 'dart:ui';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_link.dart';
import '../../models/doctor.dart';

class DataService extends GetxController {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();
  Future<List<Doctor>> getAllDoctor(VoidCallback callBack) async {
    List<Doctor> listDoctor = [];
    try {
      print('Get all doctor function is called');

      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/doctors/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {}
    } catch (e) {
      print('err ${e.toString()}');
    } finally {
      callBack();
    }
    return listDoctor;
  }
}
