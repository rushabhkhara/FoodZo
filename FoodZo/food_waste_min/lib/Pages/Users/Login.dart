import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_waste_min/Pages/Users/signup.dart';
import 'package:food_waste_min/Pages/home.dart';

class LoginPage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
//  final Function toggleView;
//
//  LoginPage({this.toggleView}) ;
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text("Sign In"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign Up"),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: Form (
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height:10.0),
              TextFormField (
                decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width:2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink,width:2.0)
                    )
                ),
                validator: (val) => val.isEmpty ? "Please enter your Email": null,
                onChanged: (val){

                  setState(() {
                    _email = val;
                  });
                },
              ),
              SizedBox(height:10.0),
              TextFormField (
                decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(width:2.0,color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(width:2.0,color: Colors.pink)
                    )
                ),


                obscureText: true,
                validator: (val) => val.isEmpty ? "Please enter your Password": null,
                onChanged: (val){
                  setState(() {
                    _password = val;
                  });
                },
              ),
              SizedBox(height:10.0),
              RaisedButton(
                color: Colors.pink,
                child: Text(
                  "Sign In",
                  style: TextStyle(color:Colors.white),
                ),
                onPressed: signIn,

              ),
              SizedBox(height:15.0),
              Text(
                error,
                style: TextStyle(fontSize: 14.0,color:Colors.red),
              )

            ],
          ),
        ),
      ),
    );
  }

 void signIn() async{
    final formState = _formkey.currentState ;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user ;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(user:user)));
      }catch(e){
        print(e.message);
      }
    }
  }
}
