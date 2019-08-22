import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:intl/intl.dart';
import 'Attendance.dart';
import 'AttendanceTake.dart';

class ShowAndTakeAttendancePage extends StatefulWidget {
  final String scheduleId;
  final String date;
  ShowAndTakeAttendancePage({Key key, @required this.scheduleId,@required this.date})
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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage("http://202.66.172.112:4242/sgterp/public/studentReg_images/181902007/Pic_SGT188207766.jpg"),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
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



                                         Flexible(
                                               child: Container(
                                                 height: 50,
                                                 width: 100,
                                                 child: Image.asset(getSwitchValue(index),
                                         ),
                                               )),

                                    ],
                                  )),

                            ],
                          ),
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
        title: Text('Attendance'),
      ),
      body: Center(
        child: _myListView(context),
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
    final f = new DateFormat('MM/dd//yyyy');
    final f2 = new DateFormat('dd MMMM yyyy');

//    newDate = f2.format(date);
    String localDate = f.format(DateTime.now());
    final uri =
        'http://202.66.172.112:4242/sgterp/resources/attendanceList/faculty?scheduleId=${widget.scheduleId}&date=$localDate';
//    var match = {"regNum": _phoneNumberController.text};
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
        initialAttendance =
            rest.map<AttendanceTake>((json) => AttendanceTake.fromJson(json)).toList();

        print(initialAttendance.length);
      });
//      print('${initialAttendance[21].picUrl}');

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
    picurl = "http://202.66.172.112:4242" + picurl;
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
    if(initialAttendance[index].presentAbsent == "P"){
      return 'assets/active.png';
    }else if(initialAttendance[index].presentAbsent == "A"){
      return 'assets/inactive.png';
    }
    else{
      return 'assets/inactive.png';

    }
  }
}
