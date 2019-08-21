class AttendanceShow {
  final String subjectName;
  final String course;
  final String startTime;
  final String endTime;
  final String scheduleId;

  // All dogs start out at 10, because they're good dogs.

  AttendanceShow({this.course, this.startTime, this.endTime, this.subjectName, this.scheduleId});
  factory AttendanceShow.fromJson(Map<String, dynamic> json) {
    return AttendanceShow(
//        source: Source.fromJson(json["source"]),
        subjectName: json["subjectName"],
        course: json["course"],
        startTime: json["startTime"],
        scheduleId: json["scheduleId"],
        endTime:  json["endTime"]);

  }
}