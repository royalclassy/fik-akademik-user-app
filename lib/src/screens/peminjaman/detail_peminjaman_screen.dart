import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:class_leap/src/screens/peminjaman/semua_pinjam_screen.dart';

class DetailpeminjamanPage extends StatefulWidget {
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
  final String tipeRuang;

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
    required this.tipeRuang,
  });

  @override
  _DetailpeminjamanPageState createState() => _DetailpeminjamanPageState();
}

class _DetailpeminjamanPageState extends State<DetailpeminjamanPage> {
  late BuildContext _context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

  @override
  void dispose() {
    // No need to use _context here
    super.dispose();
  }

  // Future<void> _cancelPeminjaman(String idPeminjaman) async {
  //   try {
  //     var response = await batalPeminjaman(idPeminjaman);
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(content: Text('Peminjaman berhasil dibatalkan: ${response['message']}')),
  //     );
  //     Navigator.of(_context).pop(); // Close the dialog
  //     print('Peminjaman berhasil dibatalkan');
  //     //print the data
  //     print(response);
  //     Navigator.of(_context).pop(); // Navigate back to the previous page
  //     Navigator.pushReplacement(
  //       _context,
  //       MaterialPageRoute(builder: (context) => SemuadaftarPage(room: widget.tipeRuang,)),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(content: Text('Gagal membatalkan peminjaman: $e')),
  //     );
  //   }
  // }

  Future<void> _cancelPeminjaman(String idPeminjaman) async {
  try {
    var response = await batalPeminjaman(idPeminjaman);
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Peminjaman berhasil dibatalkan')),
    );
    Navigator.pushAndRemoveUntil(
      _context,
      MaterialPageRoute(builder: (context) => SemuadaftarPage(room: widget.tipeRuang)),
      (Route<dynamic> route) => false,
    );
  } catch (e) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Gagal membatalkan peminjaman')),
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _cancelPeminjaman(widget.idPeminjaman);
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
            buildRowWithDivider('Status', widget.status),
            buildRowWithDivider('Nama', widget.studentName),
            buildRowWithDivider('Ruangan', widget.ruangan),
            buildRowWithDivider('Tipe Ruangan', widget.tipeRuang),
            buildRowWithDivider('Tgl Pinjam', widget.bookDate),
            buildRowWithDivider('Jam Mulai', widget.jamMulai),
            buildRowWithDivider('Jam Selesai', widget.jamSelesai),
            buildRowWithDivider('Jml Pengguna', widget.jumlahPengguna),
            buildRowWithDivider('Keterangan', widget.keterangan),
            if (widget.status == 'ditolak') ...[
              const SizedBox(height: 8),
              const Text(
                'Alasan Ditolak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.alasan_penolakan,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: widget.status == 'menunggu'
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