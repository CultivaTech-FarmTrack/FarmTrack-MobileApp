class Event{
  final int id;
  final String title;
  final String date;
  const Event(this.title, this.id, this.date);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        json['id'],
        json['title'],
        json['date']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date
    };
  }

  static Map<String, dynamic> encodeMap(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      if (value is List<Event>) {
        List<Map<String, dynamic>> eventList = value.map((event) => event.toJson()).toList();
        newMap[key.toString()] = eventList;
      } else {
        newMap[key.toString()] = value;
      }
    });
    return newMap;
  }

  static Map<String, dynamic> decodeMap(Map<String, dynamic> jsonMap) {
    Map<String, dynamic> newMap = {};
    jsonMap.forEach((key, value) {
      if (value is List<dynamic>) {
        List<Event> eventList = value.map((eventJson) => Event.fromJson(eventJson)).toList();
        newMap[key.toString()] = eventList;
      } else {
        newMap[key.toString()] = value;
      }
    });
    return newMap;
  }
}