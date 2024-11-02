import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';

class DosenCard extends StatelessWidget {
  final String dosenName;
  final String dosenCode;

  const DosenCard({
    Key? key,
    required this.dosenName,
    required this.dosenCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1, // Lebih kecil dibandingkan kolom mata kuliah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dosenName, // Data Dosen
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            dosenCode, // Kode Dosen
          ),
        ],
      ),
    );
  }
}