import 'package:flutter/material.dart';

class DetailkendalaPage extends StatelessWidget {
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String bentuk;
  final String deskripsi;
  final String status;
  final String keteranganPenyelesaian;

  const DetailkendalaPage({
    super.key,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
    required this.status,
    required this.keteranganPenyelesaian,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kendala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $studentName'),
            Text('NIM: $studentNim'),
            Text('Tanggal: $inputDate'),
            Text('Ruangan: $ruangan'),
            Text('Jenis: $jenis'),
            Text('Bentuk: $bentuk'),
            Text('Deskripsi: $deskripsi'),
            Text('Status: $status'),
            if (status == 'Selesai') ...[
              const SizedBox(height: 8),
              const Text(
                'Keterangan Penyelesaian:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                keteranganPenyelesaian,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}