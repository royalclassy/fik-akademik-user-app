import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButtonTwo({super.key, 
    required this.label,
    required this.onPressed,
    this.color = const Color(0xff2f4858)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjusted padding
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
              const TextStyle( // Fallback text style if not defined in theme
                fontSize: 12, // Smaller font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}