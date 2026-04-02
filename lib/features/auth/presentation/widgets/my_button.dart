import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const MyButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: theme.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
