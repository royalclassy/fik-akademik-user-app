import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButtonTwo({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xff2f4858),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}