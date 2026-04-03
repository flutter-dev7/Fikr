import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.montserrat(
        color: theme.primary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.tertiary, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primary, width: 2),
        ),
        filled: true,
        fillColor: theme.secondary,
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: theme.primary),
      ),
    );
  }
}
