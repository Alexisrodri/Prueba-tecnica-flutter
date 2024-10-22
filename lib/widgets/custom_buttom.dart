import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 85,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF000E4E),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF88F8FA),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width * 0.15, 0);
    path.lineTo(width * 0.85, 0);
    path.lineTo(width, height * 0.5);
    path.lineTo(width * 0.85, height);
    path.lineTo(width * 0.15, height);
    path.lineTo(0, height * 0.5);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
