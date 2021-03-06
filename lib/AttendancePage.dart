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

class AttendancePage extends StatefulWidget {
  final DateTime date;
  AttendancePage({Key key, @required this.date}) : super(key: key);

  @override
  _AttendancePage createState() => new _AttendancePage();
}

class _AttendancePage extends State<AttendancePage> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String userId;
  List<AttendanceShow> initialAttendance;
  SharedPreferences sharedPreferences;

  String username;
  String mobile;
  String picurl;
  String userid;
  DateTime dateget;
  String newDate;
  String headerDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProfileData();
    final f = new DateFormat('dd MMMM yyyy');
    final f2 = new DateFormat('dd MMMM yyyy');

//    DateTime lovcation = DateTime(widget.date.toIso8601String());
    headerDate = f.format(widget.date);
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
    dateget = widget.date;
    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount: initialAttendance == null ? 0 : initialAttendance.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowAndTakeAttendancePage(
                      scheduleId: initialAttendance[index].scheduleId,
                      date: dateget.toString()),
                ),
              );
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
                    child:
                        Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                       Container(
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

                                    Container(
                                        padding: EdgeInsets.only(left: 6),

                                        child: Text(
                                        initialAttendance[index]
                                            .course
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      )),

                                    Container(
                                          child: Row(
                                        children: <Widget>[
                                          Container(
                                                padding: EdgeInsets.only(left: 6),
                                                child: Text(
                                                  "TIME :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                )),

                                      Container(
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

                                        ],
                                      )),

                                     Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: getBatch(initialAttendance[index])
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                            ),

                       CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xffffc909),
                                ),
                              ),

                          ],
                        )),

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
        title: Text('Attendance'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            color: Color(0xff009999),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage("$picurl"),
                      radius: 50,
                      backgroundColor: Colors.transparent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "$username ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "$userid",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "+91-$mobile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
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
                  '$headerDate',
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
  Future<void> callAttendanceApi() async {
    Map abc = new Map();
    final f = new DateFormat('MM/dd/yyyy');
    final f2 = new DateFormat('dd MMMM yyyy');

    DateTime lovcation = DateTime.parse(dateget.toIso8601String());
    String localDate = f.format(lovcation);
    final uri =
        '${Constants.url}/scheduleList/faculty/?employeeId=$userid&date=$localDate';
//    var match = {"regNum": _phoneNumberController.text};
    print(uri);
    var response = await get(
      Uri.parse(uri),
//      headers: {
//        "Accept": "application/json",
//        "Content-Type": "application/x-www-form-urlencoded"
//      },
    );

    print(response);
    print(response.body);

    abc = json.decode(response.body) as Map;
//    print(abc['details']);

    if (!abc['error']) {
      setState(() {
        var rest = abc['data'] as List;
        initialAttendance = rest
            .map<AttendanceShow>((json) => AttendanceShow.fromJson(json))
            .toList();

//        print(initialFees);
      });
    } else {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      content: new Text(abc['message']),
      _ackAlert(context);

//    ));
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

  getProfileData() async {
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

    callAttendanceApi();
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
