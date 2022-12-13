class Event {
  final String title;
  final int type;
  final String description;
  final String location;
  final DateTime time;
  Event(
      {required this.type,
      required this.time,
      required this.description,
      required this.location,
      required this.title});
}
