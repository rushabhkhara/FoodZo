import 'package:flutter/material.dart';

class FoodPrice extends StatefulWidget {
  String foodName;
  int cost;

//  int counter  = 0;
  int counter;

  FoodPrice(this.foodName, this.cost, this.counter);

  @override
  _FoodPriceState createState() =>
      _FoodPriceState(this.foodName, this.cost, this.counter);
}

class _FoodPriceState extends State<FoodPrice> {
  String foodName;
  int cost;
  int counter;

  _FoodPriceState(this.foodName, this.cost, this.counter);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      padding: EdgeInsets.all(8),
      child: Card(
//          color: Colors.white30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(8),
          child: SizedBox(
              height: 40,
              child: Row(children: [
                Text('${this.foodName}' + ':   Rs.' + '${this.cost}' + '    '),
                ButtonTheme(
                    minWidth: 44.0,
                    height: 20.0,
                    buttonColor: Colors.blueGrey,
                    child: RaisedButton(
                        onPressed: decrementCounter,
                        child: Text('-'))),
                Text('${this.counter}'),
                ButtonTheme(
                    minWidth: 44.0,
                    height: 20.0,
                    buttonColor: Colors.blueGrey,
                    child: RaisedButton(
                        onPressed: incrementCounter,
                        child: Text('+'))),
              ]))),
    );
  }

  void decrementCounter() {
    setState(() {
      this.counter--;
      widget.counter--;
    });
  }

  void incrementCounter() {
    setState(() {
      this.counter++;
      widget.counter++;
//      foodPrice.incCounter();
//      this.foodName = 'xyz' ;
//      print(this.counter);
    });
//    print(this.counter);
  }
}
