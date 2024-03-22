import 'package:flutter/material.dart';
import 'package:group_project/userProfileTab/login.dart';
import 'package:group_project/userProfileTab/signup.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(children: [
          Lottie.asset("assets/welcome-lottie.json", width: 200, height: 200),
          const Text(
            "Let's get Started!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            "Reserve a table, Pre-order your meals and",
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            "make payments immediately without",
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            "stress!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 74, 81, 117),
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text(
                "Log In",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
