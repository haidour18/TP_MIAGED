import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                          _errorMessage = null;
                        });
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: _email.toString(),
                            password: _password.toString())
                            .then((user) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home())))
                            .catchError((e) {
                          setState(() {
                            _isProcessing = false;
                            _errorMessage = e.message;
                          });
                        });
                      }
                    },
                    child: _isProcessing
                        ? CircularProgressIndicator(

                      color: Colors.deepPurple,
                    )
                        : Text(
                      'Se connecter',
                    )),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            )));
  }
}
