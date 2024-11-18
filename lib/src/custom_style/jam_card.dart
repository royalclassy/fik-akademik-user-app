import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JamCard extends StatelessWidget {
  final String jamMulai;
  final String jamSelesai;

  const JamCard({
    Key? key,
    required this.jamMulai,
    required this.jamSelesai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm'); // Format without seconds
    final inputFormat = DateFormat('HH:mm:ss'); // Format with seconds

    DateTime jamMulaiDateTime = inputFormat.parse(jamMulai);
    DateTime jamSelesaiDateTime = inputFormat.parse(jamSelesai);

    return Expanded(
      flex: 1, // Lebih kecil dibandingkan kolom mata kuliah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            timeFormat.format(jamMulaiDateTime),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            timeFormat.format(jamSelesaiDateTime),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}