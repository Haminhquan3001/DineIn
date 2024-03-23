import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:group_project/userProfileTab/contactus.dart';
import 'package:group_project/userProfileTab/editprofile.dart';
import 'package:group_project/userProfileTab/login.dart';
import 'package:group_project/userProfileTab/payment.dart';
import 'package:group_project/userProfileTab/themeProvider.dart';
import 'package:provider/provider.dart';

class User extends StatefulWidget {
  const User({super.key});
  @override
  State<User> createState() => _User();
}

class _User extends State<User> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/woman.png",
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Username",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "memo",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                title: "Edit Profile",
                icon: Icons.edit,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                title: "Payment",
                icon: Icons.payment_rounded,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Payment()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenu(
                title: "Contact Us",
                icon: Icons.phone,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUs()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SetDarkMode(),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ProfileMenu(
                title: "Log Out",
                icon: Icons.logout_rounded,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                textColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.endIcon = true,
      this.textColor});
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor?.withOpacity(0.2)),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.lime.withOpacity(0.2)),
              child: const Icon(
                Icons.arrow_right_alt_rounded,
                color: Color.fromARGB(255, 188, 165, 231),
                size: 20,
              ),
            )
          : null,
    );
  }
}

class SetDarkMode extends StatefulWidget {
  const SetDarkMode({super.key});
  @override
  State<SetDarkMode> createState() => _SetDarkMode();
}

class _SetDarkMode extends State<SetDarkMode> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: iconColor?.withOpacity(0.2)),
          child: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
              color: iconColor),
        ),
        title: Text(
          "Dark Mode",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: Switch(
          value: isDark,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              isDark = value;
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            });
          },
        ));
  }
}
