import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Yu-Gi-Oh! Card Game',
            style: TextStyle(
              fontFamily: 'YuGiOh',
              color: Colors.amber,
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[800]!,
                Colors.blueGrey.shade800,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 250,
                child: Image.asset(
                  'assets/icon/icon-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                '¡Bienvenido a Yu-Gi-Oh!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'YuGiOh',
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  context.push('/cards');
                },
                title: 'Ver  cartas',
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  context.push('/cards-banlist');
                },
                title: 'Ver BandList',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
