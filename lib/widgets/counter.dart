import "package:flutter/material.dart";
import "package:covid_19/constant.dart";

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key? key,
    required this.number,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color.withOpacity(.26),
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '$number',
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
        Text(title,
            style: const TextStyle(fontSize: 16, color: kTextLightColor)),
      ],
    );
  }
}
