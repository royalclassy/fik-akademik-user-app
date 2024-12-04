import 'package:flutter/material.dart';

class DateRangeButton extends StatelessWidget {
  final VoidCallback onSelect;
  final VoidCallback onClear;
  final String? dateRangeText;

  const DateRangeButton({
    Key? key,
    required this.onSelect,
    required this.onClear,
    this.dateRangeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelect,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Pilih Rentang Waktu'),
          if (dateRangeText != null) ...[
            const SizedBox(width: 8),
            Text(dateRangeText!),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
          ],
        ],
      ),
    );
  }
}