class Attendance {
  final String subjectName;
  final String percentage;

  // All dogs start out at 10, because they're good dogs.

  Attendance({this.subjectName, this.percentage});
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
//        source: Source.fromJson(json["source"]),
        subjectName: json["course"],
        percentage:  json["startTime"]);

  }
}