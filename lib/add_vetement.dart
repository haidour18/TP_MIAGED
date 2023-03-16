import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

const List<String> list = <String>['Enfant', 'Homme', 'Femme'];

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerSize = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerImg = TextEditingController();
  TextEditingController _controllerBrand = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();



  String dropdownValue = list.first;

//Ma méthode avant code

  Future addToList() async {
    CollectionReference _reference =
    FirebaseFirestore.instance.collection('vetements');

    String itemName = _controllerName.text;
    String itemPrice = _controllerPrice.text;
    String itemBrand = _controllerBrand.text;
    String itemSize = _controllerSize.text;
    String itemImg = _controllerImg.text;
    String itemCategory = dropdownValue;

    //Create a Map of data
    Map<String, String> dataToSend = {
      'title': itemName,
      'prix': itemPrice,
      'categorie': itemCategory,
      'image': itemImg,
      'marque': itemBrand,
      'taille': itemSize
    };

    //Add a new item
    _reference.add(dataToSend);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un article'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    labelText: "Ajouter le nom de l'article",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'SVP le nom';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerBrand,
                  decoration: InputDecoration(
                    labelText: "Ajouter la marque",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'SVP la marque ';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Ajouter le prix",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Prix à saisir';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerSize,
                  decoration: InputDecoration(
                    labelText: "Ajouter la taille",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ajoutez la taille SVP';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerImg,
                  decoration: InputDecoration(
                    labelText: "Ajouter le lien de l'image",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Il faut ajouter une image';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text("Choisissez la catégorie"),
                DropdownButton<String>(
                  hint: Text("Catégorie"),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        addToList();
                      }
                    },
                    child: Text("Ajoutez l'article"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
