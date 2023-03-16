
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetmobile/panier.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('vetements').doc(itemId);
    _futureData = _reference.get();

  }

  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();

}

class _ItemDetailsState extends State<ItemDetails> {
  late Map data;
  bool _clicked = false;



  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;


    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
   var id= FirebaseFirestore.instance.collection("users-cart-items").doc();

    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({

      "title": {data['title']},
      "marque": {data['marque']},
      "taille": {data['taille']},
      "prix": {data['prix']},
      "image": {data['image']},
    }).then((value) => print(id)


    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: widget._futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return Center(
              child: Column(
                children: [
                  Image.network(
                    '${data['image']}',
                    height: 250,
                    width: 250,
                  ),
                  Text('${data['title']}'),
                  Text('${data['taille']}'),
                  Text('${data['marque']}'),
                  Text('${data['prix']}'),

                  ElevatedButton(

                      onPressed: _clicked
                          ? null
                          : () {

                        addToCart();
                        setState(() => _clicked = true); // set it to true now
                      },

                     child: Text('Ajouter au panier'))
                  ,
              ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
