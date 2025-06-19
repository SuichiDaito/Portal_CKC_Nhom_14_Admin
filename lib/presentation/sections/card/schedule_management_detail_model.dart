class ScheduleDetail {
  String room;
  List<Map<String, dynamic>> schedules;

  ScheduleDetail({this.room = '', this.schedules = const []});

  ScheduleDetail copyWith({
    String? room,
    List<Map<String, dynamic>>? schedules,
  }) {
    return ScheduleDetail(
      room: room ?? this.room,
      schedules: schedules != null
          ? List<Map<String, dynamic>>.from(schedules)
          : List<Map<String, dynamic>>.from(this.schedules),
    );
  }
}
