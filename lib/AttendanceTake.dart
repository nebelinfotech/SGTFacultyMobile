
import 'package:json_annotation/json_annotation.dart';


class AttendanceTake {
   String studentName;
   String regNum;
   String presentAbsent;
   String picUrl;

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
  Map<String, dynamic> toJson() => _attendanceToJson(this);


Map<String, dynamic> _attendanceToJson(AttendanceTake instance) => <String, dynamic>{
  'name': instance.studentName,
  'picPath': instance.picUrl,
  'status': instance.presentAbsent,
  'studentId': instance.regNum,
};
}