import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? city;
  String? birthday;
  String? adresse;
  String? username;
  String? code;
  String? password;

  TextEditingController codeController =
      TextEditingController(text: "Your initial value");
  TextEditingController passController =
      TextEditingController(text: "Your initial value");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Mon profil'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
       onPressed: () {
         if (_formKey.currentState!.validate()) {
Update();         }

      },
              child: Text(
                "Valider",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Text("Loading data...Please wait");
            var _formKey;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 30),
                              TextFormField(
                                initialValue: username,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                              TextFormField(
                                initialValue: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),


                                onChanged: (value) {
                                  password = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer du texte';
                                  } else {
                                    int? parsedValue = int.tryParse(value);
                                    if (parsedValue == null || parsedValue <= 6) {
                                      return 'La valeur doit être supérieure à 6';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                initialValue: birthday,
                                decoration: InputDecoration(
                                  labelText: 'Birthday',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                                onChanged: (value) {
                                  birthday = value;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                initialValue: adresse,
                                decoration: InputDecoration(
                                  labelText: 'Adresse',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                                onChanged: (value) {
                                  adresse = value;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                initialValue: city,
                                decoration: InputDecoration(
                                  labelText: 'Cité',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                                onChanged: (value) {
                                  city = value;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                initialValue: code,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Code Postal',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                                onChanged: (value) {
                                  code = value;
                                },
                              ),
                            ],
                          ),
                        )),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                      onPressed: () {
                        Signout();
                      },
                      child: Text(
                        'Se déconnecter',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  ///////////////////FOnctions ici//////////////////

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()!['username'];
        password = ds.data()!['password'];

        birthday = ds.data()!['birthday'];
        adresse = ds.data()!['adresse'];
        city = ds.data()!['city'];
        code = ds.data()!['code'];
      }).catchError((e) {
        print(e);
      });
  }

  Signout() {
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future Update() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({
      'city': city,
      'birthday': birthday,
      'adresse': adresse,
      'code': code,
    });

    firebaseUser.updatePassword(password!).then((_) {
      print("Successfully changed password");

      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .update({
        'password': password,
      });
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
