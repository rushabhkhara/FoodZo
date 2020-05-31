import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_min/Pages/Users/categoryDetails.dart';

class FoodItems extends StatelessWidget {
  String itemName;

//  int cost;
  var categoryDetails = new Map();
  final FirebaseUser user;

  FoodItems(this.user, this.itemName, this.categoryDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
//    width: 10,
      padding: EdgeInsets.all(8),
      child: Card(
//          color: Colors.white30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: SizedBox(
//              height: 40,
//              width: 100,
              child: Row(
                  children: [
                    RaisedButton(
                        child: Text(
                            '${this.itemName}'
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CategoryDetails(this.user, this.itemName,
                                      this.categoryDetails)));
                        }
                    ),

                  ])
          )
      ),

    );
  }

}
