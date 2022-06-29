import 'package:authapp/models/user-model.dart';
import 'package:authapp/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:authapp/screens/loginpage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 233, 199, 240),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text("Success",
                  style: TextStyle(color: Colors.lightGreen, fontSize: 30.0)),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(180),
                color: Colors.purple,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginScreen())));
                    },
                    padding: EdgeInsets.all(20),
                    minWidth: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 12,
                    child: Column(children: <Widget>[
                      //   Text("sign out", style: TextStyle(color: Colors.white)),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ])),
              )
            ])));
  }
}
