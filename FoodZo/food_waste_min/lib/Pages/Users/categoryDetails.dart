import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///D:/flutterProjects/food_waste_min/lib/Pages/Cart/cart.dart';
import 'package:food_waste_min/Pages/Users/foodPrice.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryDetails extends StatefulWidget {
  var categoryDetails = new Map();
  final FirebaseUser user;
  String itemName;

  CategoryDetails(this.user, itemName, categoryDetails) {
    this.categoryDetails = categoryDetails;
    this.itemName = itemName;
    print(itemName);
    print(categoryDetails);
  }

  @override
  _CategoryDetailsState createState() =>
      _CategoryDetailsState(this.user, this.itemName, this.categoryDetails);
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var categoryDetails = new Map();
  var list = <FoodPrice>[];
  int counter = 0;
  final FirebaseUser user;
  String itemName;
  final databaseReference = FirebaseDatabase.instance.reference();

  _CategoryDetailsState(this.user, this.itemName, this.categoryDetails) {
    this.categoryDetails.forEach((key, value) {
      FoodPrice foodPrice = FoodPrice(key, value, this.counter);
      list.add(foodPrice);
    });
    print(list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('${this.itemName}')),
        body: ListView(children: <Widget>[


           ListView.builder(
//                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child: list[index]);
                    }),
            Expanded(
                child: Align(
                    alignment: FractionalOffset.center,
                    child: RaisedButton(
                        onPressed: addtoCart, child: Text('Add to Cart'))))
          ]),
        );
  }

  void addtoCart() async {
//    foodPrice.getCounter(this.categoryDetails);
    int existingTotal = 0;
//    int flag = -1;
    int cost, count;
    String productName;
    var savedData = new Map();
    print(widget.user.email);
    int index = widget.user.email.indexOf('@');
    String username = widget.user.email.substring(0, index);
    try {
      await databaseReference
          .child(username)
          .child('Cart')
          .once()
          .then((DataSnapshot snapshot) {
        print('Existing Cart:${snapshot.value}');
        savedData = snapshot.value;
      });
    } catch (e) {
      print(e.message);
    }

    var storeDetails = new Map();
    var add = new Map();
    int total = 0;
    int actual = 1;

    for (int i = 0; i < list.length; i++) {
      print("${list[i].foodName}");
      print("${list[i].cost}");
      print("${list[i].counter}");
      if (list[i].counter > 0) {
        total = total + list[i].counter * list[i].cost;
        add[list[i].foodName] = list[i].cost;
        add['count'] = list[i].counter;
        storeDetails['$actual'] = add;
        add = {};
        actual++;
      }
      print(total);
    }
    if (savedData != null) {
      savedData.forEach((key, value) {
        if (value is int) {
          existingTotal = value;
          total += existingTotal;
        } else {
          value.forEach((item, val) {
            if (item != 'count') {
              productName = item;
              cost = val;
//              flag += 1;
            } else {
              count = val;
            }
          });
//          flag = -1;
          add[productName] = cost;
          add['count'] = count;
          storeDetails['$actual'] = add;
          actual++;
          add = {};
        }
      });
    }
    storeDetails['total'] = total;
    print(storeDetails);
    print(username);
    try {
      await databaseReference.child(username).child('Cart').set(storeDetails);
      print("Done Successfully");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Cart(this.user, storeDetails)));
    } catch (e) {
      print(e.message);
    }
  }
}
