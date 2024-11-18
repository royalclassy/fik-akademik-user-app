import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/dummy_report.dart';

class DetailkendalaPage extends StatelessWidget {
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String bentuk;
  final String deskripsi;
  final String status;

  DetailkendalaPage({
    Key? key,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Laporan Kendala",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
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
            buildRowWithDivider('Jenis Kendala', jenis),
            buildRowWithDivider('Bentuk Kendala', bentuk),
            buildRowWithDivider('Deskripsi', deskripsi),
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