import 'package:flutter/material.dart';

class ButtonPending extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonPending({super.key, 
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[500], // Background color fallback to primary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
              const TextStyle( // Fallback text style jika tidak ada di tema
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}