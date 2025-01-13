import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final ButtonStyle style;

  const MyButton({
    super.key,
    required this.onTap,
    required this.style,
    required this.child,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isPressed
                  ? [const Color(0xFF999999), const Color(0xFF999999)]
                  : _isHovering
                      ? [const Color(0xFFBBBBBB), const Color(0xFFBBBBBB)]
                      : [const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovering && !_isPressed
                ? [const BoxShadow(color: Colors.black26, blurRadius: 5)]
                : [],
          ),
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                color: _isPressed ? Colors.black54 : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 2,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
