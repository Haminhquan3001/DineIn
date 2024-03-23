import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_project/userProfileTab/signup.dart';
import 'package:group_project/userProfileTab/themeProvider.dart';
import 'package:provider/provider.dart';
import 'user.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool isChecked = false;
  bool _showPassword = true;
  final _usernameController = TextEditingController();
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
    _usernameController.dispose();
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
              "Welcome back!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
                "Enter your credientials below to log in to your account",
                style: TextStyle(fontSize: 25)),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              children: [
                _usernameTextFieldWidget(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextFieldWidget(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rememberMeWidget(),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ]),
                const SizedBox(
                  height: 15,
                ),
                _logInButtonWidget(),
                const SizedBox(
                  height: 10,
                ),
                _orContinueWithWidget(),
                const SizedBox(
                  height: 10,
                ),
                _signInWithGoogleButtonWidget(),
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

  Widget _logInButtonWidget() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // print(
          //     "USERNAMEEEEE is: ${_usernameController.text} PASSSSSSSS is: ${_passwordController.text}");
          //NEED TO VERIFY THE USERNAME AND LOGIN
          //IF SUCESS RETURN EITHER HOME PAGE OR USER ACCOUNT PAGE
          //IF NOT RETURN THIS PAGE WITH POP UP
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const User()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 74, 81, 117),
            side: BorderSide.none,
            shape: const StadiumBorder()),
        child: const Text(
          "Log In",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _usernameTextFieldWidget() {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
          hintText: "Username or Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(width: 2, color: Colors.black)),
          label: const Text("Username or email"),
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
      controller: _passwordController,
      obscureText: _showPassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(width: 2, color: Colors.black)),
          label: const Text("Password"),
          prefixIcon: Icon(
            Icons.fingerprint,
            color: iconColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
                _showPassword
                    ? Icons.remove_red_eye_sharp
                    : Icons.remove_red_eye_outlined,
                color: iconColor),
            onPressed: _toggle,
          )),
    );
  }

  Widget _rememberMeWidget() {
    return Row(
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (checked) {
              setState(() {
                isChecked = checked!;
              });
            }),
        const Text("Remember me?", style: TextStyle(fontSize: 15)),
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

  Widget _signInWithGoogleButtonWidget() {
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
            "Sign In with Google",
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  Widget _signUpWidget() {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        },
        child:
            const Text.rich(TextSpan(text: "Don't have an account?", children: [
          TextSpan(
            text: " Sign Up",
            style: TextStyle(color: Colors.red),
          )
        ])));
  }
}
