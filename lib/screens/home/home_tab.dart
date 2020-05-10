
import 'package:bakeryapp/models/user.dart';
import 'package:bakeryapp/screens/home/settings_form.dart';
import 'package:bakeryapp/services/auth.dart';
import 'package:bakeryapp/services/database.dart';
import 'package:bakeryapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return Container(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.black87,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person,color: Colors.white, size: 20,),
                label: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 17),),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings, color: Colors.white,size: 20,),
                label: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 17)),
                onPressed: () => _showSettingsPanel(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.jpg"),
                    fit: BoxFit.cover,
                  )),
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    StreamBuilder<UserData>(
                        stream: DatabaseService(uid: user.uid).userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UserData userData = snapshot.data;
                            String name = userData.name;
                            String email = userData.email;
                            String status = userData.member;
                            double spend = userData.spending;
                            return Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 90)),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white70.withOpacity(0.8),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text('Welcome Back!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 65,
                                          fontFamily: "DancingScript",
                                        ),),
                                      SizedBox(height: 50,),
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: AssetImage("assets/images/profile.jpg"),
                                      ),
                                      SizedBox(height: 30,),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('$name',
                                            style: TextStyle(fontSize: 40,),
                                            textAlign: TextAlign.left,),
                                            SizedBox(height: 30.0,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('Email:        $email'
                                                    '\nSpent:       \$${spend.toStringAsFixed(2)}'
                                                    '\nMember:   $status',
                                                  style: TextStyle(
                                                      fontSize: 17),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          else {return Loading();}
                        }
                    ),
                  ]),
            ),
          ),
        ));
  }
}