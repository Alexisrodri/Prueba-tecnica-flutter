import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/imgs/background.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                height: 200,
                child: Image.asset(
                  'assets/icon/icon-logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Bienvenido a Yu-Gi-Oh!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'YuGiOh',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  context.push('/cards');
                },
                title: 'Ver Cartas',
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
