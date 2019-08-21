import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard2Page.dart';

import 'LecturePage.dart';
import 'RegisterPage.dart';
import 'AttendancePage.dart';
import 'ShowAndTakeAttendancePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey ,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => new MyHomePage(),
        '/registerPage': (BuildContext context) => new RegisterPage(),
        '/dashboard2Page': (BuildContext context) => new Dashboard2Page(),
        '/lecturePage': (BuildContext context) => new LecturePage(),
        '/attendancePage': (BuildContext context) => new AttendancePage(),
        '/showAndTakeAttendancePage': (BuildContext context) => new ShowAndTakeAttendancePage(),


    },
    );
  }
}




class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences sharedPreferences;
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String login;
  @override
  void initState() {
    super.initState();
    getProfileData();
//    RegisterPage();
  }

  @override
  Widget build(BuildContext context) {
      return Container();
  }



 Future<void> getProfileData() async {


      final SharedPreferences prefs = await _sprefs;
      login = prefs.getString("login") ?? 'no';

      if(login == "yes"){
        Navigator.of(context).pushReplacementNamed('/dashboard2Page');
      }else{
        Navigator.of(context).pushReplacementNamed('/registerPage');
      }


  }
}
