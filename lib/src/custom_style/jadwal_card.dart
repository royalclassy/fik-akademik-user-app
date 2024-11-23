import 'package:flutter/material.dart';

class JadwalCard extends StatelessWidget {
  final String namaMatkul;
  final String kodeMatkul;
  final String namaDosen;
  final String kodeDosen;
  final String ruangan;

  const JadwalCard({super.key, 
    required this.namaMatkul,
    required this.kodeMatkul,
    required this.namaDosen,
    required this.kodeDosen,
    required this.ruangan,
  });

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
              namaMatkul, // Data Mata Kuliah
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              kodeMatkul, // Kode Mata Kuliah
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_pin, color: Colors.white,),
                const SizedBox(width: 12),
                Text(ruangan, style: const TextStyle(color: Colors.white,),),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(namaDosen, style: const TextStyle(color: Colors.white),),
                      Text(kodeDosen, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}