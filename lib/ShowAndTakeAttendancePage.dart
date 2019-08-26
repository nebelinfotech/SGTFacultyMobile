import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:intl/intl.dart';
import 'Attendance.dart';
import 'AttendanceTake.dart';
import 'Constants.dart';

class ShowAndTakeAttendancePage extends StatefulWidget {
  final String scheduleId;
  final String date;

  ShowAndTakeAttendancePage(
      {Key key, @required this.scheduleId, @required this.date})
      : super(key: key);

  @override
  _ShowAndTakeAttendancePage createState() => new _ShowAndTakeAttendancePage();
}

class _ShowAndTakeAttendancePage extends State<ShowAndTakeAttendancePage> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String userId;
  List<AttendanceTake> initialAttendance;
  SharedPreferences sharedPreferences;

  String username;
  String mobile;
  String picurl;
  String userid;
  String newDate;
  bool enableDiableSubmitButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DateTime todayDate = DateTime.now().toUtc();
    var d1 = DateTime.utc(todayDate.year,todayDate.month,todayDate.day);
    DateTime selectedDate = DateTime.parse(widget.date).toUtc();
    var d2 = DateTime.utc(selectedDate.year,selectedDate.month,selectedDate.day);

    if(d1 == d2 || d2 == d1.subtract(new Duration(days: 1))){
      enableDiableSubmitButton = true;
      
    }
    else
      {
        enableDiableSubmitButton = false;
      }
    getProfileData();

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
    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount: initialAttendance == null ? 0 : initialAttendance.length,
        itemBuilder: (context, index) {
          return GestureDetector(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "http://202.66.172.112:8080${initialAttendance[index].picUrl}",
                          ),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    initialAttendance[index]
                                        .studentName
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text(
                                        'REG:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ),
                                Container(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text(
                                        initialAttendance[index]
                                            .regNum
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Flexible(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 50,
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                if (getSwitchValue(index) ==
                                    "assets/active.png") {
                                  initialAttendance[index].presentAbsent = "A";
                                } else {
                                  initialAttendance[index].presentAbsent = "P";
                                }
                                setState(() {});
                              },
                              child: Image.asset(
                                getSwitchValue(index),
                              ),
                            ),
                          ),
                        )),
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


    Widget getSubmitButtontype(BuildContext context) {
      if(enableDiableSubmitButton){
        return  GestureDetector(
          onTap: () {
//              submitAttendance();
            _submitAttendanceAlert(context);
          },
          child:


          Container(
            color: Color(0xff007ba4),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                margin: EdgeInsets.all(0.0),
                elevation: 16.0,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border(
                            left:
                            BorderSide(color: Color(0xffffc909), width: 5))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Submit Attendance',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),


                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xffffc909),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }else {
        return
          Container(
            color: Color(0xff007ba4),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                margin: EdgeInsets.all(0.0),
                elevation: 16.0,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border(
                            left:
                            BorderSide(color: Color(0xffffc909), width: 5))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Attendance Update Not Allowed',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007ba4),
        title: Text('Attendance'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                  color: Color(0xff007ba4), child: _myListView(context))),
         
         getSubmitButtontype(context)
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

//    newDate = f2.format(date);
    print(widget.date);
    String localDate = f.format(DateTime.parse((widget.date)));
    final uri =
        '${Constants.url}/attendanceList/faculty?scheduleId=${widget.scheduleId}&date=$localDate';
//    var match = {"regNum": _phoneNumberController.text};
    print(uri);
    var response = await get(
      Uri.parse(uri),
//      headers: {
//        "Accept": "application/json",
//        "Content-Type": "application/x-www-form-urlencoded"
//      },
    );

    print(response.body);

    abc = json.decode(response.body) as Map;
//    print(abc['details']);

    if (!abc['error']) {
      setState(() {
        var rest = abc['studentList'] as List;
        initialAttendance = rest
            .map<AttendanceTake>((json) => AttendanceTake.fromJson(json))
            .toList();

        print(initialAttendance);
      });
    } else {
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

  Future<void> _submitAttendanceAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do You Want to Submit the Attendance ?',
            style: TextStyle(
                color: Colors.indigo,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 35,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(
                        0xffffc909,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      submitAttendance();
                    },
                  ),
                ],
              ),
            ),
          ),
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

  String getSwitchValue(int index) {
    if (initialAttendance[index].presentAbsent == "P") {
      return 'assets/active.png';
    } else if (initialAttendance[index].presentAbsent == "A") {
      return 'assets/inactive.png';
    } else {
      return 'assets/inactive.png';
    }
  }

  Future<void> submitAttendance() async {
    Map abc = new Map();
    final f = new DateFormat('MM/dd/yyyy');
    final f2 = new DateFormat('dd MMMM yyyy');

    List<String> sd = new List();
    for (int i = 0; i < initialAttendance.length; i++) {
      if (initialAttendance[i].presentAbsent == "A") {
        sd.add(initialAttendance[i].regNum);
      }
    }
    String s = '';
    print(sd);
    s = sd.join(',');

    String localDate = f.format(DateTime.parse(widget.date));
    final uri =
        '${Constants.url}/markAttendance/faculty?scheduleId=${widget.scheduleId}&attendanceDate=$localDate&employeeId=$userid&regNum=$s';
//    var match = {"regNum": _phoneNumberController.text};
    print(uri);
    var response = await post(Uri.parse(uri));

    print(response.body);
    abc = json.decode(response.body) as Map;

    if (!abc['error']) {
      Navigator.pop(context);
    } else {
      _ackAlert(context);

//    ));
    }
  }

  void _showNotAlloweddialog(BuildContext context) {}


}
