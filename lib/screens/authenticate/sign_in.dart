import 'package:bakeryapp/services/auth.dart';
import 'package:bakeryapp/shared/form_border.dart';
import 'package:bakeryapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/orders_tab.jpg"),
                      fit: BoxFit.cover,
                    )),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5),
                          borderRadius:
                          BorderRadius.all(Radius.circular(30.0))),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "Bakery \nBrera",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "DancingScript",
                                    fontSize: 95,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                Container(
                                  width: 320.0,
                                  child: TextFormField(
                                    decoration:
                                        textInputDecoration.copyWith(hintText: 'Enter email'),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  width: 320.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration:
                                        textInputDecoration.copyWith(hintText: 'Enter password'),
                                    validator: (val) => val.length < 6
                                        ? 'Enter a password 6+ chars long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  width: 130,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.white10)
                                    ),
                                      color: Colors.pink[400],
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Text(
                                              "Sign in",
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.9),
                                                  fontSize: 20.0,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {
                                      setState(() {
                                        Color(50);
                                      });
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .signInWithEmailAndPassword(email, password);
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              error =
                                                  'Could not sign in with those credentials';
                                            });
                                          }
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('New user? ', style: TextStyle(color: Colors.white),),
                                      InkWell(
                                        onTap: () { setState(() {Color(300);});widget.toggleView();},
                                        child: Text('Register',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Bold',
                                              color: Colors.lightBlue[200],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
