import 'package:flutter/cupertino.dart';

class PressedImage extends StatefulWidget {
  final Image image;
  final VoidCallback onPressed;

  const PressedImage({
    required this.image,
    required this.onPressed,
  });

  @override
  _PressedImageState createState() => _PressedImageState();
}

class _PressedImageState extends State<PressedImage> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _updatePressed(true),
      onTapUp: (_) {
        _updatePressed(false);
        widget.onPressed();
      },
      onTapCancel: () => _updatePressed(false),
      child: AnimatedScale(
        scale: _isPressed ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.image,
      ),
    );
  }

  void _updatePressed(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }
}
