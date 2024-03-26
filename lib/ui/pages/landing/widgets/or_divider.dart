import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.8,
          ),
        ),
        Text("OR", style: TextStyle(fontSize: 15)),
        Expanded(
            child: Divider(
          thickness: 0.8,
        ))
      ],
    );
  }
}
