import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart';

class DetailpeminjamanPage extends StatelessWidget {
  final String idPeminjaman;
  final String studentName;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;
  final String status;
  final String alasan_penolakan;

  const DetailpeminjamanPage({
    super.key,
    required this.idPeminjaman,
    required this.studentName,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.status,
    required this.alasan_penolakan,
  });

  Future<void> _cancelPeminjaman(BuildContext context, String idPeminjaman) async {
    try {
      var response = await batalPeminjaman(idPeminjaman);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Peminjaman berhasil dibatalkan: ${response['message']}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membatalkan peminjaman: $e')),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembatalan'),
          content: Text('Apakah kamu yakin mau membatalkan peminjaman ruang?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelPeminjaman(context, idPeminjaman);
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
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
            buildRowWithDivider('Ruangan', ruangan),
            buildRowWithDivider('Tgl Pinjam', bookDate),
            buildRowWithDivider('Jam Mulai', jamMulai),
            buildRowWithDivider('Jam Selesai', jamSelesai),
            buildRowWithDivider('Jml Pengguna', jumlahPengguna),
            buildRowWithDivider('Keterangan', keterangan),
            if (status == 'ditolak') ...[
              const SizedBox(height: 8),
              const Text(
                'Alasan Ditolak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                alasan_penolakan,
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
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Batalkan Peminjaman',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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