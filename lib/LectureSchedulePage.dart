import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:intl/intl.dart';
import 'Attendance.dart';
import 'AttendanceShow.dart';
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
  List<AttendanceShow> initialAttendance ;
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
    date = widget.date;
    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount:initialAttendance == null ? 0 : initialAttendance.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowAndTakeAttendancePage(scheduleId: initialAttendance[index].scheduleId, date: newDate),
                ),
              );
            },
            child: Card(

              elevation: 8.0,
              child: ClipPath(
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),

                child: Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Color(0xffffc909), width: 5))),
                  child: Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text(initialAttendance[index].subjectName.toUpperCase() +' |',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),overflow: TextOverflow.ellipsis,)),
                                ),
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text(initialAttendance[index].course.toUpperCase(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),overflow: TextOverflow.ellipsis,)),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xffffc909),
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text("TIME :"
                                        ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),overflow: TextOverflow.ellipsis,)),
                                ),
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Text(initialAttendance[index].startTime.toUpperCase() + ' TO ' + initialAttendance[index].endTime.toUpperCase()
                                        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),overflow: TextOverflow.ellipsis,)),
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
        title: Text('Attendance'),
      ),
      body: Column(

        children: <Widget>[
          Container(
            height: 50,
            child:  Padding(

              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Flexible(


                      child: GestureDetector(
                        onTap: (){
                          selectedday = "mon";
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
                          child: Text("Mon",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),Flexible(


                      child: GestureDetector(
                        onTap: (){
                          selectedday = "tue";
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
                          child: Text("Tue",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),Flexible(
                      child: GestureDetector(
                        onTap: (){
                          selectedday = "wed";
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
                          child: Text("Wed",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),Flexible(

                      child: GestureDetector(
                        onTap: (){
                          selectedday = "thu";
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
                          child: Text("Thu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),Flexible(


                      child: GestureDetector(
                        onTap: (){
                          selectedday = "fri";
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
                          child: Text("Fri",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),Flexible(

                      child: GestureDetector(
                        onTap: (){
                          selectedday = "sat";
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
                          child: Text("Sat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container
            (
            color: Color(0xff007ba4),
            height: 25,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text("${DateTime.now().toString()}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
    final f = new DateFormat('dd/MM/yyyy');
    final f2 = new DateFormat('dd MMMM yyyy');
//
//    newDate = f2.format(DateTime.now());
//    String localDate = f.format(newDate);
    final uri = 'http://202.66.172.112:4242/sgterp/resources/scheduleList/faculty/?employeeId=$userid&date=08/05/2019';
//    var match = {"regNum": _phoneNumberController.text};
    print(uri);
    var response = await get(Uri.parse(uri),
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

        var rest   = abc['data'] as List;
        initialAttendance = rest.map<AttendanceShow>((json)=>AttendanceShow.fromJson(json)).toList();

//        print(initialFees);
      });

    } else {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      content: new Text(abc['message']),
      _ackAlert(context);

//    ));
    }




    this.setState(() {

    });


  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Data Found',style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.bold),),
          content: const Text('There is no data related to this registration number'),
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


}
