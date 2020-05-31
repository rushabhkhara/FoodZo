import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Users/fooditems.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;

  @override
  _HomePageState createState() => _HomePageState(this.user);
}

class _HomePageState extends State<HomePage> {
  var list = <FoodItems>[];
  final FirebaseUser user;
  _HomePageState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu')),
        body: Column(children: <Widget>[
          list.length != 0
              ? new ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: list[index],
                        );
                  })

              : RaisedButton(
                  onPressed: getItemList,
                  child: Text('Get Menu'),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                ),
        ]
        )
    );
  }

  getItemList() async {
    var savedata = new Map();
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference
        .child('RestaurantMenu')
        .once()
        .then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      savedata = snapshot.value;
    });
    setState(() {
      savedata.forEach((key, value) {
        print(value);
        FoodItems foodItem = FoodItems(this.user,key,value);
        list.add(foodItem);
      });
      print(list.length);
    });
  }
}
