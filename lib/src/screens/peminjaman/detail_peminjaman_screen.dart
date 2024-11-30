import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart';

class DetailpeminjamanPage extends StatelessWidget {
  final String idPeminjaman;
  final String studentName;
  // final String studentNim;
  // final String inputDate;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;
  final String status;
  final String alasan;

  const DetailpeminjamanPage({
    super.key,
    required this.idPeminjaman,
    required this.studentName,
    // required this.studentNim,
    // required this.inputDate,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.status,
    this.alasan = '',
  });

Future<void> _cancelPeminjaman(idPeminjaman) async {
  try {
    var response = await batalPeminjaman(idPeminjaman);
    // Handle successful cancellation
    print('Peminjaman cancelled successfully: ${response['message']}');
  } catch (e) {
    // Handle error
    print('Failed to cancel peminjaman: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Peminjaman",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowWithDivider('Status', status),
            buildRowWithDivider('Nama', studentName),
            // buildRowWithDivider('NIM', studentNim),
            // buildRowWithDivider('Tgl Input', inputDate),
            buildRowWithDivider('Ruangan', ruangan),
            buildRowWithDivider('Tgl Pinjam', bookDate),
            buildRowWithDivider('Jam Mulai', jamMulai),
            buildRowWithDivider('Jam Selesai', jamSelesai),
            buildRowWithDivider('Jml Pengguna', jumlahPengguna),
            buildRowWithDivider('Keterangan', keterangan),
            if (status == 'Ditolak') ...[
              const SizedBox(height: 8),
              const Text(
                'Alasan Ditolak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                alasan,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: status == 'menunggu'
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _cancelPeminjaman(idPeminjaman);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Batalkan Peminjaman', style:
            TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        ),
      )
          : null,
    );
  }

  Widget buildRowWithDivider(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SizedBox(
              width: 140,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xffede9d0)),
      ],
    );
  }
}