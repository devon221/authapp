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

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  void signUp(
    String email,
    String password,
  ) async {
    postDetailsToFirestore() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel usermodel = UserModel();

      usermodel.email = user!.email;
      usermodel.username = usernamecontroller.text;
      usermodel.password = passwordcontroller.text;
      usermodel.uid = user.uid;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(usermodel.toMap());
      Fluttertoast.showToast(msg: "account created succesfully !");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) => {Fluttertoast.showToast(msg: e!.message)});
  }

  @override
  Widget build(BuildContext context) {
    final passwordInputField = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a valid value !");
        }
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      decoration: InputDecoration(
          hintText: "enter password",
          labelText: "password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );

    final emailInputField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      obscureText: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a valid value !");
        }
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "enter email",
          labelText: "email",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );

    final usernameInputField = TextFormField(
      autofocus: false,
      controller: usernamecontroller,
      obscureText: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a valid value !");
        }
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "enter username",
          labelText: "username",
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );

    final inputBtn = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(180),
        color: Colors.purple,
        child: MaterialButton(
          onPressed: () {
            signUp(emailcontroller.text, passwordcontroller.text);
          },
          padding: EdgeInsets.all(20),
          minWidth: MediaQuery.of(context).size.width / 8,
          height: MediaQuery.of(context).size.height / 12,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ));

    final login = Material(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("already have an account ? "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => LoginScreen())));
          },
          child: Text(
            "Log In",
            style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        )
      ],
    ));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 199, 240),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 30.0),
                    usernameInputField,
                    SizedBox(height: 30.0),
                    emailInputField,
                    SizedBox(height: 30.0),
                    passwordInputField,
                    SizedBox(height: 20.0),
                    inputBtn,
                    SizedBox(height: 30.0),
                    login
                  ],
                ),
                key: _formkey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
