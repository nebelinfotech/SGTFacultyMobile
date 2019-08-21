import 'dart:async';
import 'dart:convert';

import 'package:app_faculty/Dashboard2Page.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  final String title = 'Verify';
  SignInPage({Key key, this.vId}) : super(key: key);
  final String vId;
  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  SharedPreferences sharedPreferences;
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String userid;
  String mobile;
  String password;
  String otpNew;

  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.white);

  final TextEditingController _smsController = TextEditingController();

  bool visible = false;
  String _message = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
    Timer(Duration(seconds: 5), () {
//      print("Yeah, this line is printed after 3 seconds");
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          color: Color(0xff009999),
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      'Enter Password',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
                    SizedBox(
                      height: 30,
                    ),


                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: false,
                      style: style,
                      controller: _smsController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                    ),

                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.center,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff009999),
                          child: FloatingActionButton(
                              backgroundColor: Color(0xffffc909),
                              onPressed: () async {
//                            await
//                            _signInWithPhoneNumber();

                                await _matchOtp();

                                //callRegisterApi();
                              },
                              child: Icon(Icons.arrow_forward)),
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _message,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }



  _saveProfileData(String profilePic, String userName, String userId,
      String mobileNumber, int otp) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("profile-picture", profilePic);
      sharedPreferences.setString("userId", userId);
      sharedPreferences.setString("name", userName);
      sharedPreferences.setString("mobile", mobileNumber);
      sharedPreferences.commit();
    });
  }

  getProfileData() async {
    final SharedPreferences prefs = await _sprefs;
    userid = prefs.getString("userId") ?? 'No Data Found';
    mobile = prefs.getString("mobile") ?? 'No Data Found';
    password = prefs.getString("password") ?? 'No Data Found';

    this.setState(() {
      userid = userid;
      mobile = mobile.substring(mobile.length - 5);
      password = password;
    });
  }

  _matchOtp() async {
    if (password.toString() == _smsController.text) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("login", "yes");

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard2Page(),
          ));
    } else {
      _ackAlert(context);
    }
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Invalid OTP',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text('Please enter the correct otp'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
