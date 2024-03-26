import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/pages/landing/widgets/google_credentials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/or_divider.dart';
import 'package:group_project/ui/pages/landing/widgets/password_crendetials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/redirect_to.dart';
import 'package:group_project/ui/widgets/input_password_form.dart';
import 'package:group_project/ui/widgets/input_text_form.dart';
import 'package:group_project/ui/widgets/space_y.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _Login();
}

class _Login extends State<LoginPage> {
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
                InputTextForm(
                  text: 'Username or email',
                  controller: _usernameController,
                  icon: Icons.person_3_outlined,
                ),
                const SpaceY(20),
                InputPasswordForm(
                  text: 'Password',
                  controller: _passwordController,
                  showPassword: _showPassword,
                  toggleShowPassword: _toggle,
                ),
                const SpaceY(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rememberMeWidget(),
                    TextButton(
                      onPressed: () {}, // TODO: implement forgot password
                      child: const Text("Forgot Password?",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                const SpaceY(15),
                PasswordCredentialsButton(
                  loginOrSignupText: 'Log In',
                  onPressed: () {}, // TODO: implement login with password
                ),
                const SpaceY(10),
                const OrDivider(),
                const SpaceY(10),
                GoogleCredentialsButton(
                  loginOrSignupText: 'Login',
                  onPressed: () => context.replace('/login'),
                ),
                const SpaceY(10),
                RedirectTo(
                  messages: const ["Don't have an accont?", " Sign Up"],
                  onPressed: () => context.replace('/signup'),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
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
}
