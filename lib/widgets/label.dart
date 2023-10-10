import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  final double value;
  Color? color = Colors.blue.shade300;

  Label({
    super.key,
    required this.value,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 160,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color?.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color?.withOpacity(0.2)),
            child: Text(
              value.round().toString(),
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
