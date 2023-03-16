import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Panier extends StatelessWidget {
  Panier({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference = FirebaseFirestore.instance
      .collection("users-cart-items")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("items");

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Text('Mon panier'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
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
                      'title': e['title'][0],
                      'taille': e['taille'][0],
                      'prix': e['prix'][0],
                      'image': e['image'][0],
                    })
                .toList();

            double TotalPanier() {
              double sum = 0;
              for (var element in items) sum += double.parse(element['prix']);
              return sum;
            }

            //Display the list
            return Column(children: [
              ListView.builder(
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
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start, // for left side

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('Titre :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple)),
                                      Text(thisItem['title']),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('Taille :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple)),
                                      Text(thisItem['taille']),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('Prix :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple)),
                                      Text(thisItem['prix'].toString() + '€'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("users-cart-items")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("items")
                                      .doc(thisItem['id'])
                                      .delete();
                                },
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    );
                  }),
              SizedBox(
                height: 26.0,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  height: 50,
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TotalPanier().toString() + '€',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
            ]);
          }
          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
    );
  }
}
