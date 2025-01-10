import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart';

class DetailkendalaPage extends StatefulWidget {
  final String idKendala;
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
    required this.idKendala,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
    required this.status,
    required this.keteranganPenyelesaian,});

  @override
  State<DetailkendalaPage> createState() => _DetailkendalaPageState();
}

class _DetailkendalaPageState extends State<DetailkendalaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Kendala",
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
            buildRowWithDivider('ID Transaksi', widget.idKendala),
            buildRowWithDivider('Nama', widget.studentName),
            buildRowWithDivider('NIM', widget.studentNim),
            buildRowWithDivider('Tanggal', widget.inputDate),
            buildRowWithDivider('Ruangan', widget.ruangan),
            buildRowWithDivider('Jenis',widget.jenis),
            buildRowWithDivider('Bentuk', widget.bentuk),
            buildRowWithDivider('Deskripsi', widget.deskripsi),
            buildRowWithDivider('Status', widget.status),
            if (widget.status == 'Selesai') ...[
              const SizedBox(height: 8),
              const Text(
                'Keterangan Penyelesaian:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.keteranganPenyelesaian,
                style: const TextStyle(fontSize: 14),
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