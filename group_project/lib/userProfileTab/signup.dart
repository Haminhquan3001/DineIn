import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_project/userProfileTab/themeProvider.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'package:group_project/userProfileTab/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool _isChecked = false;
  bool _showPassword = true;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text("Enter your credientials below to create an account",
                style: TextStyle(fontSize: 25)),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              children: [
                _fullnameTextFieldWidget(),
                const SizedBox(
                  height: 20,
                ),
                _emailTextFieldWidget(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextFieldWidget(),
                const SizedBox(
                  height: 10,
                ),
                _termAndPolicyWidget(),
                const SizedBox(
                  height: 10,
                ),
                _signUpButtonWidget(),
                const SizedBox(
                  height: 10,
                ),
                _orContinueWithWidget(),
                const SizedBox(
                  height: 10,
                ),
                _signUpWithGoogleButtonWidget(),
                const SizedBox(
                  height: 10,
                ),
                _signUpWidget(),
              ],
            ))
          ],
        ),
      ),
    ));
  }

  Widget _signUpButtonWidget() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // RETREIEVE USER INPUT BY USING CONTROLLER.TEXT
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const User()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 74, 81, 117),
            side: BorderSide.none,
            shape: const StadiumBorder()),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _emailTextFieldWidget() {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(width: 2, color: Colors.black)),
          label: const Text("Email"),
          prefixIcon: Icon(
            Icons.email,
            color: iconColor,
          )),
    );
  }

  Widget _fullnameTextFieldWidget() {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return TextFormField(
      controller: _fullnameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(width: 2, color: Colors.black)),
          label: const Text("Enter your Full Name"),
          prefixIcon: Icon(
            Icons.person_3_outlined,
            color: iconColor,
          )),
    );
  }

  Widget _passwordTextFieldWidget() {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return TextFormField(
      obscureText: _showPassword,
      controller: _passwordController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(width: 2, color: Colors.black)),
          label: const Text("Password"),
          prefixIcon: Icon(Icons.fingerprint, color: iconColor),
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword
                  ? Icons.remove_red_eye_sharp
                  : Icons.remove_red_eye_outlined,
              color: iconColor,
            ),
            onPressed: _toggle,
          )),
    );
  }

  Widget _termAndPolicyWidget() {
    return Row(
      children: [
        Checkbox(
            value: _isChecked,
            onChanged: (checked) {
              setState(() {
                _isChecked = checked!;
              });
            }),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "I accept the ",
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          TextSpan(
              text: " terms and privacy policy",
              style: const TextStyle(color: Colors.red),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const TermAndPolicy();
                      });
                })
        ]))
      ],
    );
  }

  Widget _orContinueWithWidget() {
    return const Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 0.8,
        )),
        Text("OR", style: TextStyle(fontSize: 15)),
        Expanded(
            child: Divider(
          thickness: 0.8,
        ))
      ],
    );
  }

  Widget _signUpWithGoogleButtonWidget() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 226, 226, 226),
              side: BorderSide.none,
              shape: const StadiumBorder()),
          onPressed: () {},
          icon: Container(
              padding: const EdgeInsets.only(right: 5),
              child: Image.asset(
                "assets/google.png",
                width: 20,
              )),
          label: const Text(
            "Sign up with Google",
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
    );
  }

  Widget _signUpWidget() {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        },
        child: const Text.rich(TextSpan(
            text: "Already have an account?",
            style: TextStyle(fontSize: 15),
            children: [
              TextSpan(
                text: " Log in",
                style: TextStyle(color: Colors.red, fontSize: 15),
              )
            ])));
  }
}

class TermAndPolicy extends StatelessWidget {
  const TermAndPolicy({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Center(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("You are in the Terrm And Policy page")],
          )),
        ));
  }
}
