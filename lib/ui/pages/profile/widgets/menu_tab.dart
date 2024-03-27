import 'package:flutter/material.dart';

class MenuTab extends StatelessWidget {
  const MenuTab(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.textColor});
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.lime.withOpacity(0.2)),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color.fromARGB(255, 188, 165, 231),
          size: 20,
        ),
      ),
    );
  }
}
