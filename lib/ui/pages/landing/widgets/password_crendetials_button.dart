import 'package:flutter/material.dart';

class PasswordCredentialsButton extends StatelessWidget {
  const PasswordCredentialsButton(
      {super.key, required this.loginOrSignupText, required this.onPressed});

  final String loginOrSignupText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 74, 81, 117),
            side: BorderSide.none,
            shape: const StadiumBorder()),
        child: Text(
          loginOrSignupText,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
