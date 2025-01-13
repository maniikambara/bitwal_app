import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 16.0),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 16.0, color: Color(0x80FFFFFF)),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[400],
                  ),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                )
              : null,
        ),
      ),
    );
  }
}
