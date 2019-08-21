import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LectureSchedulePage.dart';
import 'RegisterPage.dart';


class Dashboard2Page extends StatefulWidget {
  @override
  _Dashboard2Page createState() => _Dashboard2Page();
}

class _Dashboard2Page extends State<Dashboard2Page> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  SharedPreferences sharedPreferences;

  String username;
  String mobile;
  String picurl;
  String userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD".toUpperCase()),
        elevation: .1,
        backgroundColor: Color(0xff007ba4),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff47b5be),
          child: ListView(
            children: <Widget>[
              Container(
                height: 150,
                color: Color(0xff009999),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8.0,
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Color(0xffffc909), width: 5))),
                      child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/lecturePage');
                          },
                          title: Text("Attendance"),
                          leading: Icon(
                            Icons.apps,
                            color: Color(0xff009999),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xffffc909),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8.0,
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Color(0xffffc909), width: 5))),
                      child: ListTile(
                          onTap: () {
                            _ackAlert(context);

                          },
                          title: Text("Logout"),
                          leading: Icon(
                            Icons.exit_to_app,
                            color: Color(0xff009999),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xffffc909),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xff47b5be),
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: ListView(
//          crossAxisCount: 2,
          children: <Widget>[
//            makeDashboardItem("Attendance", Icons.apps),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Color(0xffffc909), width: 5))),
                    child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/lecturePage');
                        },
                        contentPadding: EdgeInsets.all(2.0),
                        leading: Icon(
                          Icons.apps,
                          size: 40.0,
                          color: Colors.teal,
                        ),
                        title: Text('Attendance',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black)),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Color(0xffffc909),
                          ),
                        )),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Color(0xffffc909), width: 5))),
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LectureSchedulePage(),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.all(2.0),
                        leading: Icon(
                          Icons.apps,
                          size: 40.0,
                          color: Colors.teal,
                        ),
                        title: Text('Lectures',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black)),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Color(0xffffc909),
                          ),
                        )),
                  ),
                ),
              ),
            ),
//            makeDashboardItem("Fees", Icons.attach_money),

//            makeDashboardItem("Date sheet", Icons.calendar_today),

//            makeDashboardItem("Results", Icons.assessment),

//            makeDashboardItem("Lecture", Icons.assignment),

          ],
        ),
      ),
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
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are You Sure',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text('Do you want to logout'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
//                Navigator.of(context).pop();
              logout();

              },
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("login", "no");
    Navigator.of(context).pop();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
        builder: (context) => RegisterPage()
    ),
    ModalRoute.withName("/registerPage"));



  }

}
