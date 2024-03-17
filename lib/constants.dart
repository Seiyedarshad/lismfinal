import 'package:flutter/material.dart';

const bottomBGColor = Color.fromARGB(255, 10, 55, 58);
const middleBGColor = Color.fromARGB(255, 14, 79, 84);
const topBGColor = Color.fromARGB(255, 63, 202, 212);
const navbarcolor = Color(0xFFD9D9D9);

const searchcColor = Color(0xFF353535);

const apiKey = "6fb20181b47c36d9895e354d96eb5099";

Widget verticalSpace(double val) => SizedBox(height: val);

Widget horizontalSpace(double val) => SizedBox(width: val);

Widget textstyle1(double size, String data) => Text(
      data,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
    );

AppBar defaultAppBar() => AppBar(
    backgroundColor: const Color.fromARGB(255, 63, 202, 212),
    title: const Row(children: [
      Image(
        image: AssetImage('assets/logotext.png'),
        alignment: Alignment.center,
        height: 300,
        width: 150,
      ),
    ]));
