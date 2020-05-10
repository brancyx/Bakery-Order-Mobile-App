import 'package:bakeryapp/services/auth.dart';
import 'package:bakeryapp/shared/form_border.dart';
import 'package:bakeryapp/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

    return loading
        ? Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () {
                  widget.toggleView();
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back,
                    size: 45.0, // add custom icons also
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 0),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/users_tab.jpg"),
                fit: BoxFit.cover,
              )),
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          "Join our Family",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "DancingScript",
                              fontSize: 105,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Enter email'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Enter password'),
                                obscureText: true,
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                              SizedBox(height: 20.0),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white10)
                                ),
                                  color: Colors.pink[400],
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.registerWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Please supply a valid email';
                                        });
                                      }
                                    }
                                  }),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
  }
}
