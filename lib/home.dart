import 'package:flutter/material.dart';
import 'package:projetmobile/list-vetements.dart';
import 'package:projetmobile/panier.dart';
import 'package:projetmobile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(

        onPageChanged: (index) {
          setState(() {
            _currentindex = index;
          });
        },
        controller: _pageController,
        children: [
          ItemList(),
          Panier(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.deepPurple,

        currentIndex: _currentindex,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
          _pageController.jumpToPage(_currentindex);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Acheter',),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Panier'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
