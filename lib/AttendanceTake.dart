class AttendanceTake {
  final String studentName;
  final String regNum;
  final String presentAbsent;
  final String picUrl;

  // All dogs start out at 10, because they're good dogs.

  AttendanceTake({this.studentName, this.regNum,this.presentAbsent,this.picUrl});
  factory AttendanceTake.fromJson(Map<String, dynamic> json) {
    return AttendanceTake(
//        source: Source.fromJson(json["source"]),
        studentName: json["name"],
        picUrl: json["picPath"],
        presentAbsent: json["status"],
        regNum:  json["studentId"]);

  }
}