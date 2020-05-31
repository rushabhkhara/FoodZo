import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_min/Pages/Users/foodPrice.dart';
import 'package:food_waste_min/Pages/home.dart';

class Cart extends StatefulWidget {
  var storeDetails = new Map();
  final FirebaseUser user;

  Cart(this.user, this.storeDetails) {
//    print(this.storeDetails);
  }

  @override
  _CartState createState() => _CartState(this.user, this.storeDetails);
}

class _CartState extends State<Cart> {
  var storeDetails = new Map();
  int total;
  var Details = <FoodPrice>[];
  final FirebaseUser user;
  final databaseReference = FirebaseDatabase.instance.reference();

  _CartState(this.user, this.storeDetails) {
    print("Hello000");
    int flag = -1;
    String itemName;
    int count;
    int cost;
    print("Data: ${this.storeDetails}");
    this.storeDetails.forEach((key, value) {
      if (value is int) {
        print("Total");
        this.total = value;
      } else {
        value.forEach((item, val) {
          if (flag == -1) {
            itemName = item;
            cost = val;
            flag += 1;
          } else {
            count = val;
          }
        });
        flag = -1;
        FoodPrice foodPrice = FoodPrice(itemName, cost, count);
        Details.add(foodPrice);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView(children: <Widget>[
        Row(
          //ROW 1
          children: [
            new Expanded(
                child: ListView.builder(
//             scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Details.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child: Details[index]);
                    })),
          ],
        ),
        Row(//ROW 2
            children: [
          Container(
              margin: EdgeInsets.all(25.0),
              child: Align(
                  alignment: FractionalOffset.centerRight,
                  child: Text(('Total:${this.total}'))))
        ]),
        Row(//ROW 3
            children: [
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Align(
                      alignment: FractionalOffset.centerRight,
                      child: RaisedButton(
                        onPressed: updateCart,
                        child: Text('Update Cart'),
                      )))
            ]),
        Row(//ROW 3
            children: [
          Container(
              margin: EdgeInsets.all(25.0),
              child: Align(
                  alignment: FractionalOffset.centerRight,
                  child: RaisedButton(
                    onPressed: backtoMenu,
                    child: Text('Add more items'),
                  )))
        ]),
        Row(//ROW 4
            children: [
          Container(
              margin: EdgeInsets.all(25.0),
              child: Align(
                  alignment: FractionalOffset.centerRight,
                  child: RaisedButton(
                    onPressed: placeOrder,
                    child: Text('Place Order'),
                  )))
        ]),
      ]),
    );
  }

  void updateCart() async{

    var storeDetails = new Map();
    var add = new Map();
    int total = 0;
    int actual = 1;
    print(widget.user.email);
    int index = widget.user.email.indexOf('@');
    String username = widget.user.email.substring(0, index);
    for (int i = 0; i < Details.length; i++) {
      print("${Details[i].foodName}");
      print("${Details[i].cost}");
      print("${Details[i].counter}");
      if (Details[i].counter > 0) {
        total = total + Details[i].counter * Details[i].cost;
        add[Details[i].foodName] = Details[i].cost;
        add['count'] = Details[i].counter;
        storeDetails['$actual'] = add;
        add = {};
        actual++;
      }
      print(total);
    }
    storeDetails['total'] = total;
    print(storeDetails);
    print(username);

    try{
      await databaseReference.child(username).child('Cart').set(storeDetails);
      print("Done Successfully");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Cart(this.user, storeDetails)));
    }catch(e){
      print(e.message);
    }
  }


  void placeOrder() async{

    var storeDetails = new Map();
    var add = new Map();
    int total = 0;
    int actual = 1;
    print(widget.user.email);
    int index = widget.user.email.indexOf('@');
    String username = widget.user.email.substring(0, index);
    for (int i = 0; i < Details.length; i++) {
      print("${Details[i].foodName}");
      print("${Details[i].cost}");
      print("${Details[i].counter}");
      if (Details[i].counter > 0) {
        total = total + Details[i].counter * Details[i].cost;
        add[Details[i].foodName] = Details[i].cost;
        add['count'] = Details[i].counter;
        storeDetails['$actual'] = add;
        add = {};
        actual++;
      }
      print(total);
    }
    storeDetails['total'] = total;
    print(storeDetails);
    print(username);

    DateTime now = new DateTime.now();
    print(now);
    String date = now.day.toString();
    date+="-";
    date+=now.month.toString();
    date+="-";
    date+=now.year.toString();
    print(date);
    try{
      await databaseReference.child(username).child('Cart').remove();
      print("Done Successfully");
      try{
        await databaseReference.child(username).child('Orders').child(date).push().set(storeDetails);
        print("Order placed");
//        final snackBar = SnackBar(content: Text('Order Placed Successfully'),);
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => (HomePage(user:this.user)))) ;
      }catch(e){
        print("order problem");
        print(e.message);
      }
    }catch(e){
      print(e.message);
    }
  }

  void backtoMenu() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: this.user)));
  }
}
