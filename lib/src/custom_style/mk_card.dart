import 'package:flutter/material.dart';

class MkCard extends StatelessWidget {
  final String mkName;
  final String mkCode;

  const MkCard({super.key, required this.mkName, required this.mkCode});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xCCFF5833), // Background warna untuk mata kuliah
          borderRadius: BorderRadius.circular(12), // Tambahkan border radius
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mkName, // Data Mata Kuliah
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              mkCode, // Kode Mata Kuliah
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            // Tambahan teks untuk testing jika diperlukan
            Text(
              mkName, // Data Mata Kuliah
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              mkCode, // Kode Mata Kuliah
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}