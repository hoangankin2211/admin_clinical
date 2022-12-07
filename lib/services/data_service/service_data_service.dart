import 'package:admin_clinical/constants/api_link.dart';
import 'package:admin_clinical/models/service.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_clinical/constants/error_handing.dart';

import 'data_service.dart';

class ServiceDataService {
  ServiceDataService._privateConstructor();
  static ServiceDataService instance = ServiceDataService._privateConstructor();

  final Map<String, Service> _services = {};

  void addLocalServiceData(String key, Service service) {
    _services.putIfAbsent(key, () => service);
  }

  bool deleteLocalServiceData(String key) {
    if (!_services.containsKey(key)) {
      return false;
    }
    _services.remove(key);
    return true;
  }

  Map<String, Service> get service => _services;

  Future<bool> fetchAllDataService() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiLink.uri}/api/service/getAllServicesData"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> extractedData = jsonDecode(response.body);
      print(extractedData);

      if (extractedData.containsKey('services')) {
        List<dynamic> temp = extractedData['services'];
        for (int i = 0; i < temp.length; i++) {
          Map<String, dynamic> map = temp[i];
          _services.addAll({map['_id']: Service.fromJson(map)});
        }
        print(_services.length);
        DataService.instance.checkFetchData.value.add(1);
        return true;
      }
    } catch (e) {
      print('fetchAllDataService: ${e.toString()}');
    }
    return false;
  }

  Future<Service?> addNewService(Map<String, dynamic> serviceMap) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiLink.uri}/api/service/addService"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(serviceMap),
      );

      final Map<String, dynamic> extractedData = jsonDecode(response.body);
      print(extractedData);

      if (extractedData.containsKey('isSuccess') &&
          extractedData['isSuccess']) {
        String id = extractedData['id'];
        serviceMap['id'] = id;
        Service newService = Service.fromJson(serviceMap);
        _services.addAll({id: newService});
        return newService;
      }
    } catch (e) {
      print('fetchAllDataService: ${e.toString()}');
    }
    return null;
  }
}
