class Lectures {
  final String lecture;
  final String course;
  final String startTime;
  final String endTime;

  // All dogs start out at 10, because they're good dogs.

  Lectures({this.lecture, this.course,this.startTime,this.endTime});
  factory Lectures.fromJson(Map<String, dynamic> json) {
    return Lectures(
//        source: Source.fromJson(json["source"]),
        lecture: json["subjectName"],
        course:  json["course"],
    startTime:  json["startTime"],
        endTime:  json["endTime"]);

  }
}