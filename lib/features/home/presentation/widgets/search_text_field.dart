import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged onChanged;
  final String hintText;
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.montserrat(
        color: theme.primary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.tertiary, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primary, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
        filled: true,
        fillColor: theme.secondary,
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: theme.primary),
      ),
    );
  }
}
