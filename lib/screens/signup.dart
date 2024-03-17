import 'package:assignment/widgets/reusedwidgets.dart';
import 'package:flutter/material.dart';
import 'package:assignment/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Sign Up"),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 58, 184, 192),
              Color.fromARGB(255, 14, 79, 84),
              Color.fromARGB(255, 10, 55, 58)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        10, MediaQuery.of(context).size.width * 0.2, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/logo.png"),
                          height: 300,
                        ),
                        const SizedBox(height: 10),
                        reusedTextField("Enter your Name", _nameController,
                            false, Icons.person_4_outlined),
                        const SizedBox(height: 20),
                        reusedTextField(
                            "Enter Username/Email",
                            _emailTextController,
                            false,
                            Icons.person_2_outlined),
                        const SizedBox(height: 20),
                        reusedTextField(
                            "Enter Password",
                            _passwordTextController,
                            true,
                            Icons.lock_clock_outlined),
                        loginSignUpButton(context, false, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        })
                      ],
                    )))));
  }
}
