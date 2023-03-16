import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_vetement.dart';
import 'details-vetement.dart';

class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
    _stream2 = _reference2.snapshots();
    _stream3 = _reference3.snapshots();
    _stream4 = _reference4.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('vetements');

  Query<Map<String, dynamic>> _reference2 = FirebaseFirestore.instance
      .collection('vetements')
      .where("categorie", isEqualTo: "Femme");

  Query<Map<String, dynamic>> _reference3 = FirebaseFirestore.instance
      .collection('vetements')
      .where("categorie", isEqualTo: "Homme");
  Query<Map<String, dynamic>> _reference4 = FirebaseFirestore.instance
      .collection('vetements')
      .where("categorie", isEqualTo: "Enfant");

  late Stream<QuerySnapshot> _stream;
  late Stream<QuerySnapshot> _stream2;
  late Stream<QuerySnapshot> _stream3;
  late Stream<QuerySnapshot> _stream4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
            title: Text('Liste des vetements'),
            bottom: const TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.clear_all_outlined), text: "Tous"),
                Tab(
                  icon: Icon(Icons.woman),
                  text: "Femme",
                ),
                Tab(
                  icon: Icon(Icons.man),
                  text: "Homme",
                ),
                Tab(
                  icon: Icon(Icons.child_friendly),
                  text: "Enfant",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //Check error
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred ${snapshot.error}'));
                  }

                  //Check if data arrived
                  if (snapshot.hasData) {
                    //get the data
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                    //Convert the documents to Maps
                    List<Map> items = documents
                        .map((e) => {
                              'id': e.id,
                              'title': e['title'],
                              'taille': e['taille'],
                              'prix': e['prix'],
                              'image': e['image'],
                              'categorie': e['categorie'],
                            })
                        .toList();

                    //Display the list
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Get the item at this index
                          Map thisItem = items[index];
                          //REturn the widget for the list items
                          return Card(
                            child: InkWell(
                              child: Row(
                                children: [
                                  Image.network(
                                    '${thisItem['image']}',
                                    height: 100.0,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // for left side

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Titre :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['title']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Taille :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['taille']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Prix :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['prix'].toString()),
                                              Text('€')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetails(thisItem['id'])));
                              },
                            ),
                          );
                        });
                  }

                  //Show loader
                  return Center(child: Text(""));
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _stream2,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //Check error
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred ${snapshot.error}'));
                  }

                  //Check if data arrived
                  if (snapshot.hasData) {
                    //get the data
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                    //Convert the documents to Maps
                    List<Map> items = documents
                        .map((e) => {
                              'id': e.id,
                              'title': e['title'],
                              'taille': e['taille'],
                              'prix': e['prix'],
                              'image': e['image']
                            })
                        .toList();

                    //Display the list
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Get the item at this index
                          Map thisItem = items[index];
                          //REturn the widget for the list items
                          return Card(
                            child: InkWell(
                              child: Row(
                                children: [
                                  Image.network(
                                    '${thisItem['image']}',
                                    height: 100.0,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // for left side

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Titre :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['title']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Taille :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['taille']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Prix :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['prix'].toString()),
                                              Text('€')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetails(thisItem['id'])));
                              },
                            ),
                          );
                        });
                  }

                  //Show loader
                  return Center(child: Text(""));
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _stream3,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //Check error
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred ${snapshot.error}'));
                  }

                  //Check if data arrived
                  if (snapshot.hasData) {
                    //get the data
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                    //Convert the documents to Maps
                    List<Map> items = documents
                        .map((e) => {
                              'id': e.id,
                              'title': e['title'],
                              'taille': e['taille'],
                              'prix': e['prix'],
                              'image': e['image']
                            })
                        .toList();

                    //Display the list
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Get the item at this index
                          Map thisItem = items[index];
                          //REturn the widget for the list items
                          return Card(
                            child: InkWell(
                              child: Row(
                                children: [
                                  Image.network(
                                    '${thisItem['image']}',
                                    height: 100.0,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // for left side

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Titre :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['title']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Taille :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['taille']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Prix :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['prix'].toString()),
                                              Text('€')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetails(thisItem['id'])));
                              },
                            ),
                          );
                        });
                  }

                  //Show loader
                  return Center(child: Text(""));
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _stream4,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //Check error
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred ${snapshot.error}'));
                  }

                  //Check if data arrived
                  if (snapshot.hasData) {
                    //get the data
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                    //Convert the documents to Maps
                    List<Map> items = documents
                        .map((e) => {
                              'id': e.id,
                              'title': e['title'],
                              'taille': e['taille'],
                              'prix': e['prix'],
                              'image': e['image']
                            })
                        .toList();

                    //Display the list
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Get the item at this index
                          Map thisItem = items[index];
                          //REturn the widget for the list items
                          return Card(
                            child: InkWell(
                              child: Row(
                                children: [
                                  Image.network(
                                    '${thisItem['image']}',
                                    height: 100.0,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // for left side

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Titre :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['title']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Taille :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['taille']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Prix :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                              ),
                                              Text(thisItem['prix'].toString()),
                                              Text('€')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetails(thisItem['id'])));
                              },
                            ),
                          );
                        });
                  }

                  //Show loader
                  return Center(child: Text(""));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddItem()));
              // Add your onPressed code here!
            },
            label: const Text('Ajouter'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.deepPurple,
          ), //Display a list // Add a FutureBuilder
        ),
      ),
    );
  }
}
