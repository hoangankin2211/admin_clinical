class NotificationModel {
  String? id;
  String? title;
  DateTime? time;
  int? check;
  NotificationModel(
      {required this.id,
      required this.title,
      required this.time,
      required this.check});
  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['_id'],
        title: json['title'],
        time: DateTime.fromMillisecondsSinceEpoch(json['time']),
        check: json['check'],
      );
}
