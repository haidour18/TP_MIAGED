import 'package:flutter/material.dart';


class ListAchat extends StatefulWidget {
  const ListAchat({Key? key}) : super(key: key);

  @override
  State<ListAchat> createState() => _ListState();
}

class _ListState extends State<ListAchat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Acheter'),),


      body: Center(child: ListView(
        padding: const EdgeInsets.all(8),

        children: [
          Container(
            child: Text('Item1'),
          ),
          Container(
            child: Text('Item2'),
          ),
          Container(
            child: Text('Item3'),
          ),
        ],
      ),),);
  }
}
