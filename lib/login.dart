import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetmobile/home.dart';

import '../Authentification.dart';
import '../profile.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: Text('MIAGED', textAlign: TextAlign.center),
          ),
          body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _emailTextController,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                    ),
                    onChanged: (value) => setState(() {
                      _email = value;
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0))),
                    onChanged: (value) => setState(() {
                      _password = value;
                    }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed:() async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          User? user = await FireAuth
                              .signInUsingEmailPassword(
                            email: _emailTextController.text,
                            password:
                            _passwordTextController.text,
                          );

                          setState(() {
                            _isProcessing = false;
                          });

                          if (user != null) {
                            Navigator.of(context)
                                .pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Home(),
                              ),
                            );
                          }
                        }

                        },


                      child: Text(
                        'Se connecter',
                      )),

                ],
              ))),
    );
  }
}
