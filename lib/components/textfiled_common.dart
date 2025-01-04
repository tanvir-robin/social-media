import 'package:flutter/material.dart';

class TextfiledCommon extends StatefulWidget {
  const TextfiledCommon({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  _TextfiledCommonState createState() => _TextfiledCommonState();
}

class _TextfiledCommonState extends State<TextfiledCommon> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF25646D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.12),
          borderSide: const BorderSide(width: .5, color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.12),
          borderSide: const BorderSide(width: .5, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  !_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
