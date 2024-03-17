import 'package:flutter/material.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/Screens/signup.dart';
import 'package:assignment/widgets/reusedwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isloggedin = false;
  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isloggedin = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isloggedin) {
      return Home();
    }
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 63, 202, 212),
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
                const Image(
                  image: AssetImage("assets/logo.png"),
                  height: 300,
                ),
                const SizedBox(height: 10),
                const Text("Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'Pacifico',
                    )),
                const SizedBox(height: 20),
                reusedTextField("Enter Username/Email", _emailTextController,
                    false, Icons.person_2_outlined),
                const SizedBox(height: 20),
                reusedTextField("Enter Password", _passwordTextController, true,
                    Icons.lock_clock_outlined),
                const SizedBox(height: 20),
                loginSignUpButton(context, true, () {
                  if (_emailTextController.text != "" &&
                      _passwordTextController.text != "") {
                    _loginSuccess(context);
                  }
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      //Wraped so the parents widget issue is solved
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: const Text(
                          "Dont have an Account? Sign Up",
                          style: TextStyle(
                              color: Color.fromARGB(153, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ))),
    );
  }

  Image bGWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
    );
  }

  Row signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account?",
            style: TextStyle(color: Colors.white60)),
        Expanded(
          //Wraped so the parents widget issue is solved
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SignUpScreen()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                  color: Color.fromARGB(153, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

Future<void> _loginSuccess(BuildContext context) async {
  // Save login state to local storage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);

  // Navigate to home page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const Home()),
  );
}
