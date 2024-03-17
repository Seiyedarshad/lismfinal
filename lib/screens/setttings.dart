import 'package:assignmentfinal/constants.dart';
import 'package:assignmentfinal/screens/signin.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  //Will  be integrated in the future

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 63, 202, 212),
          title: const Row(children: [
            Image(
              image: AssetImage('assets/logotext.png'),
              alignment: Alignment.center,
              height: 300,
              width: 150,
            ),
          ]),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [topBGColor, middleBGColor, bottomBGColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(children: [
              ListBody(children: [
                TextButton(
                    onPressed: () {
                      SnackBar;
                    },
                    child: Text(
                      "About US",
                      style: TextStyle(color: Color.fromARGB(255, 99, 64, 255)),
                    )),
                ElevatedButton(
                  child: const Text(
                    "LogOUt",
                    style: TextStyle(color: Color.fromARGB(255, 99, 64, 255)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                ),
              ])
            ]),
          ),
        ));
  }
}
