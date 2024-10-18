import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final String? secondText;
  final double? secondSize;
  final FontWeight? secondWeight;
  final String route;
  final CrossAxisAlignment? alignment;
  final IconData? icon;

  const Labels({
    super.key,
    required this.text,
    this.size = 25,
    this.weight = FontWeight.w500,
    this.secondText,
    this.secondSize = 15,
    this.secondWeight = FontWeight.normal,
    this.route = '',
    this.icon,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment!,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: weight,
            color: Colors.white,
          ),
        ),
        if (secondText != null)
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                secondText!,
                style: TextStyle(
                  fontSize: secondSize,
                  fontWeight: secondWeight,
                  color: Colors.white,
                ),
              ),
            ],
          )
      ],
    );
  }
}
