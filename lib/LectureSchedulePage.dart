import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:intl/intl.dart';
import 'Attendance.dart';
import 'AttendanceShow.dart';
import 'Constants.dart';
import 'ShowAndTakeAttendancePage.dart';

class LectureSchedulePage extends StatefulWidget {
  final DateTime date;

  LectureSchedulePage({Key key, @required this.date}) : super(key: key);

  @override
  _LectureSchedulePage createState() => new _LectureSchedulePage();
}

class _LectureSchedulePage extends State<LectureSchedulePage> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String userId;
  List<AttendanceShow> initialAttendance;

  SharedPreferences sharedPreferences;

  String username;
  String mobile;
  String picurl;
  String userid;
  DateTime date;
  String newDate;
  String selectedday = "mon";

  Color _color = Colors.white;
  Color _color1 = Colors.amber[400];
  Color _color2 = Colors.white;
  Color _color3 = Colors.white;
  Color _color4 = Colors.white;
  Color _color5 = Colors.white;
  Color _color6 = Colors.white;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(5);

  DateTime _day0;
  DateTime _day1;
  DateTime _day2;
  DateTime _day3;
  DateTime _day4;
  DateTime _day5;
  DateTime _day6;
  String dateHeader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var monday = 1;
    var now = new DateTime.now();

    while (now.weekday != monday) {
      now = now.subtract(new Duration(days: 1));
    }
    var formatter = new DateFormat('yyyy-MM-dd');
    var formatted = formatter.format(now);

//    int abc = formatted.replaceAll('"', '\\"') as int;
    _day0 = DateTime.parse(formatted);
    _day1 = _day0.toUtc().add(new Duration(days: 1)).toLocal();
    _day2 = _day1.toUtc().add(new Duration(days: 1)).toLocal();
    _day3 = _day2.toUtc().add(new Duration(days: 1)).toLocal();
    _day4 = _day3.toUtc().add(new Duration(days: 1)).toLocal();
    _day5 = _day4.toUtc().add(new Duration(days: 1)).toLocal();
    _day5 = _day5.toUtc().add(new Duration(days: 1)).toLocal();

    getProfileData(_day0);
  }

  Color getColor(int selector) {
    if (selector % 2 == 0) {
      return Colors.green;
    } else {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    date = widget.date;
    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount: initialAttendance == null ? 0 : initialAttendance.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => ShowAndTakeAttendancePage(scheduleId: initialAttendance[index].scheduleId, date: newDate),
//                ),
//              );
            },
            child: Card(
              elevation: 8.0,
              child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(color: Color(0xffffc909), width: 5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.only(left: 6),
                              child: Text(
                                initialAttendance[index]
                                    .subjectName
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    initialAttendance[index]
                                        .course
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              flex: 5,
                            ),

                          ],
                        )),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    "TIME :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    initialAttendance[index]
                                            .startTime
                                            .toUpperCase() +
                                        ' TO ' +
                                        initialAttendance[index]
                                            .endTime
                                            .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                          ],
                        )),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Flexible(
                              child: getBatch(initialAttendance[index])
                            ),
                          ],
                        )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007ba4),
        title: Text('Lectures in Week'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "mon";
                          callAttendanceApi(_day0, userid);
                          setState(() {
                            _color1 = Colors.amber[400];
                            _color2 = Colors.white;
                            _color3 = Colors.white;
                            _color4 = Colors.white;
                            _color5 = Colors.white;
                            _color6 = Colors.white;

                            // Generate a random border radius.
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color1,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Mon",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "tue";
                          callAttendanceApi(_day1, userid);

                          setState(() {
                            _color1 = Colors.white;
                            _color2 = Colors.amber[400];
                            _color3 = Colors.white;
                            _color4 = Colors.white;
                            _color5 = Colors.white;
                            _color6 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color2,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Tue",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "wed";
                          callAttendanceApi(_day2, userid);

                          setState(() {
                            _color1 = Colors.white;
                            _color2 = Colors.white;
                            _color3 = Colors.amber[400];
                            _color4 = Colors.white;
                            _color5 = Colors.white;
                            _color6 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color3,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Wed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "thu";
                          callAttendanceApi(_day3, userid);

                          setState(() {
                            _color1 = Colors.white;
                            _color2 = Colors.white;
                            _color3 = Colors.white;
                            _color4 = Colors.amber[400];
                            _color5 = Colors.white;
                            _color6 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color4,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Thu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "fri";
                          callAttendanceApi(_day4, userid);

                          setState(() {
                            _color1 = Colors.white;
                            _color2 = Colors.white;
                            _color3 = Colors.white;
                            _color4 = Colors.white;
                            _color5 = Colors.amber[400];
                            _color6 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color5,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Fri",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedday = "sat";
                          callAttendanceApi(_day5, userid);

                          setState(() {
                            _color1 = Colors.white;
                            _color2 = Colors.white;
                            _color3 = Colors.white;
                            _color4 = Colors.white;
                            _color5 = Colors.white;
                            _color6 = Colors.amber[400];
                          });
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: _color6,
                            borderRadius: _borderRadius,
                          ),
                          // Define how long the animation should take.
                          duration: Duration(seconds: 1),
                          // Provide an optional curve to make the animation feel smoother.

                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Sat",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xff007ba4),
            height: 25,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  "$dateHeader",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _myListView(context),
            ),
          )
        ],
      ),
    );
    // Material(child: _myListView(context));
  }

/*  getProfileData() async {


    final SharedPreferences prefs = await _sprefs;

    userId =  prefs .getString("userId") ?? 'No Data Found';


    callAttendanceApi();



  }*/
  Future<void> callAttendanceApi(DateTime dateTime, String uID) async {
    print(dateTime);
    final f3 = new DateFormat('dd MMMM yyyy');

//    DateTime lovcation = DateTime(widget.date.toIso8601String());
    dateHeader = f3.format(dateTime);

    Map abc = new Map();

    final f = new DateFormat('MM/dd/yyyy');
    String localDate = f.format(dateTime);
    final uri =
        '${Constants.url}/scheduleList/faculty/?employeeId=$uID&date=$localDate';
    print(uri);
    var response = await get(
      Uri.parse(uri),
    );
    abc = json.decode(response.body) as Map;

    if (!abc['error']) {
      setState(() {
        var rest = abc['data'] as List;

        initialAttendance = rest
            .map<AttendanceShow>((json) => AttendanceShow.fromJson(json))
            .toList();
      });
    } else {
      _ackAlert(context);
    }

    this.setState(() {});
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'No Data Found',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'There is no data related to this registration number'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getProfileData(DateTime dateTime) async {
    final SharedPreferences prefs = await _sprefs;
    username = prefs.getString("name") ?? 'No Data Found';
    picurl = prefs.getString("profile-picture") ?? 'name';
    mobile = prefs.getString("mobile") ?? '91-XXXXXXXXXXX';
    picurl = picurl.replaceAll("\\\\", "");
    picurl = "http://202.66.172.112:8080" + picurl;
    userid = prefs.getString("userId") ?? 'No Data Found';

    this.setState(() {
      username = username;
      picurl = picurl;
      userid = userid;
      mobile = mobile;
    });
    callAttendanceApi(dateTime, userid);
  }

 Widget getBatch(AttendanceShow initialAttendance) {
    if(initialAttendance.batch != null){
      return Container(
          padding: EdgeInsets.only(left: 6),
          child: Text(
            initialAttendance
                .semester
                .toUpperCase() +
                ' | ' +
                'BATCH '+initialAttendance
                .batch
                .toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12),
            overflow: TextOverflow.ellipsis,
          )
      );
    }else {
      return Container(
          padding: EdgeInsets.only(left: 6),
          child: Text(
            initialAttendance
                .semester
                .toUpperCase() ,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12),
            overflow: TextOverflow.ellipsis,
          )
      );
    }
 }
}
