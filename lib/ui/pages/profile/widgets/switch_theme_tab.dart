import 'package:flutter/material.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:provider/provider.dart';

class SwitchThemeTab extends StatefulWidget {
  const SwitchThemeTab({super.key});
  @override
  State<SwitchThemeTab> createState() => _SwitchThemeTab();
}

class _SwitchThemeTab extends State<SwitchThemeTab> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
          ),
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
