import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_min/Pages/Users/Login.dart';

class SignUpPage extends StatefulWidget {
//  final Function toggleView;
//  SignUpPage({this.toggleView}) ;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String error = '';
  String name = '';
  String contact ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text("Sign Up"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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
                    hintText: "Email"
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
                    hintText: "Password"
                ),
                obscureText: true,
                validator: (val) => val.length < 6 ? "Please enter a password with more than 6 char": null,
                onChanged: (val){
                  setState(() {
                    _password = val;
                  });
                },
              ),
//              SizedBox(height:10.0),
//              TextFormField (
//                decoration: InputDecoration(
//                    hintText: "Name"
//                ),
//                obscureText: false,
//
//                onChanged: (val){
//                  setState(() {
//                    name = val;
//                  });
//                },
//              ),
//              SizedBox(height:10.0),
//              TextFormField (
//                decoration: InputDecoration(
//                    hintText: "Contact"
//                ),
//                obscureText: false,
//
//                onChanged: (val){
//                  setState(() {
//                    contact = val;
//                  });
//                },
//              ),
              SizedBox(height:10.0),
              RaisedButton(
                color: Colors.pink,
                child: Text(
                  "Register",
                  style: TextStyle(color:Colors.white),
                ),
                onPressed:signUp,
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
  void signUp() async{
    final formState = _formkey.currentState ;
    if(formState.validate()){
      formState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password) ;
//        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
