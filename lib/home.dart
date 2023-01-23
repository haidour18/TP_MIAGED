import 'package:flutter/material.dart';
import 'package:projetmobile/list.dart';
import 'package:projetmobile/panier.dart';
import 'package:projetmobile/profile_page.dart';
import 'package:projetmobile/login/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';





class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  int  currentIndex = 0;






final screens=[
 ListAchat(),
   Panier(),
  ProfilePage(),


  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold (


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.purple,
        onTap:(index)=>setState(() =>currentIndex=index),

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.article),

            label: 'Acheter',
            backgroundColor: Colors.purple,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Panier',
            backgroundColor: Colors.purple,
          ),
         BottomNavigationBarItem(
         icon: Icon(Icons.account_circle),
          label: 'Profile',
          backgroundColor: Colors.purple,
        ),
        ],

      ),

 body: IndexedStack(
   index: currentIndex,
   children: screens,
 ),   );

  }
}
