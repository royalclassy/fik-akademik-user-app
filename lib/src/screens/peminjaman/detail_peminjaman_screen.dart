import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/status_accept.dart';
import 'package:class_leap/src/custom_style/status_reject.dart';
import 'package:class_leap/src/custom_style/status_pending.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';

class DetailpeminjamanPage extends StatelessWidget {
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;
  final String status;
  final String alasan;

  DetailpeminjamanPage({
    Key? key,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.status,
    required this.alasan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Peminjaman",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        iconTheme: IconThemeData(
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
            buildRowWithDivider('NIM', studentNim),
            buildRowWithDivider('Tgl Input', inputDate),
            buildRowWithDivider('Ruangan', ruangan),
            buildRowWithDivider('Tgl Pinjam', bookDate),
            buildRowWithDivider('Jam Mulai', jamMulai),
            buildRowWithDivider('Jam Selesai', jamSelesai),
            buildRowWithDivider('Jml Pengguna', jumlahPengguna),
            buildRowWithDivider('Keterangan', keterangan),
            if (status == 'Ditolak') ...[
              SizedBox(height: 8),
              Text(
                'Alasan Ditolak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                alasan,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildRowWithDivider(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 140,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0xffede9d0)),
      ],
    );
  }
}