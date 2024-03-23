import 'package:flutter/material.dart';
import 'package:group_project/userProfileTab/login.dart';
import 'package:provider/provider.dart';
import 'package:group_project/userProfileTab/theme.dart';
import 'package:group_project/userProfileTab/user.dart';
import 'package:group_project/userProfileTab/themeProvider.dart';
import 'package:group_project/userProfileTab/welcome.dart';

// THIS MAIN IS HOW I TEST MY USER PROFILE TAB DO NOT WORRY ABOUT THIS CLASS
void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Welcome();
  }
}
