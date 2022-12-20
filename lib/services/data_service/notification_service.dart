import 'dart:convert';

import 'package:admin_clinical/models/notification.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_link.dart';

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();
  RxList<NotificationModel> listNotification = RxList<NotificationModel>([]);

  Future<NotificationModel?> getNotificationById(String id) async {
    NotificationModel? result;
    try {
      final res = await http.get(
        Uri.parse('${ApiLink.uri}/api/notification/get_notification_by_id/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        result = NotificationModel.fromMap(jsonDecode(res.body));
      }
    } catch (e) {
      result = null;
    }
    return result;
  }

  Future<void> insertNotification(String title) async {
    print('inser notification is called');
    try {
      final res = await http.post(
        Uri.parse('${ApiLink.uri}/api/notification/insert_notification_data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'title': title,
          'time': DateTime.now().millisecondsSinceEpoch,
        }),
      );
      if (res.statusCode == 200) {
        print("Notification is update");
      }
    } catch (e) {
      return;
    } finally {}
  }

  Future<void> fetchAllNotificationModelData() async {
    print('Feth all notification data is called');
    try {
      final res = await http.get(
        Uri.parse('${ApiLink.uri}/api/notification/get_all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        listNotification.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          listNotification
              .add(NotificationModel.fromMap(jsonDecode(res.body)[i]));
        }
      }
    } catch (e) {
      return;
    } finally {}
  }
}
