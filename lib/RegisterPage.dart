import 'dart:convert';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Constants.dart';
import 'SignInPage.dart';
import 'RegisterPage.dart';

import 'Dashboard2Page.dart';

import 'package:shared_preferences/shared_preferences.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;
class RegisterPage extends StatefulWidget {

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _message = '';
  String _verificationId;
  TextStyle style = TextStyle(fontSize: 20.0,color: Colors.white);

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final registrationNumberField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Registration Number",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final userNameField = TextField(
      controller: _usernameController,
      obscureText: false,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),

      ),
    )  ;
    final passwordField = TextField(
      controller: _passwordController,
      obscureText: false,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),

      ),
    );
    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: FloatingActionButton(
        backgroundColor: Color(0xffffc909),


//        minWidth: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
//          await _verifyUsernamePassword();

          callSigninApi();

        },
        child: Icon(Icons.arrow_forward,color: Colors.white,)
      ),
    );

    return Scaffold(
      body: Container(
        color: Color(0xff009999),
        child: Center(
          child: Container(

            color: Color(0xff009999),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 155.0,
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
//                  SizedBox(height: 45.0),
//                  registrationNumberField,
                    SizedBox(height: 25.0),
                    userNameField,
                   /* SizedBox(height: 25.0),
                    passwordField,*/
                    SizedBox(
                      height: 35.0,
                    ),
                    registerButon,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );


  }

  Future<void>   callSigninApi()  async {

    Map abc = new Map();
    final uri = '${Constants.url}/login/faculty?employeeId=EMP-${_usernameController.text}';
    var response = await get(Uri.parse(uri),

    );


    abc = json.decode(response.body) as Map;
//    print(abc['details']);

    if (!abc['error']) {
     print(abc['otp']);

      _saveProfileData(abc['profile-picture'],abc['name'],abc['userId'],abc['mobile'],abc['password']);


    }
    else {

      _ackAlert(context);

    }







  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials',style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.bold),),
          content: const Text('Please enter the correct username and password'),
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
  _saveProfileData(String profilePic, String userName, String userId, String mobileNumber, String password) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      sharedPreferences.setString("profile-picture", profilePic);
      sharedPreferences.setString("userId", userId);
      sharedPreferences.setString("name", userName);
      sharedPreferences.setString("mobile", mobileNumber);
      sharedPreferences.setString("password", password);
      sharedPreferences.commit();
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ));
  }
}
