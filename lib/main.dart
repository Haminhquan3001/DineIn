import 'package:flutter/material.dart';
import 'package:group_project/backend/core/database/env.dart';
import 'package:provider/provider.dart';

import 'package:group_project/config/routes.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Ensures that the Flutter widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // initializing supabase instance - connection to the database
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DineIn',
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: router,
    );
  }
}
