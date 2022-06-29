import 'package:authapp/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:authapp/screens/registerpage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  void sign(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "login succesful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }
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
        usernamecontroller.text = value!;
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
            sign(usernamecontroller.text, passwordcontroller.text);
          },
          padding: EdgeInsets.all(20),
          minWidth: MediaQuery.of(context).size.width / 8,
          height: MediaQuery.of(context).size.height / 12,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ));

    final signin = Material(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("dont have an account ? "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => RegistrationScreen())));
          },
          child: Text(
            "SignUp",
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
                      "Login",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 30.0),
                    usernameInputField,
                    SizedBox(height: 30.0),
                    passwordInputField,
                    SizedBox(height: 20.0),
                    inputBtn,
                    SizedBox(height: 30.0),
                    signin
                  ],
                ),
                key: _formKey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
