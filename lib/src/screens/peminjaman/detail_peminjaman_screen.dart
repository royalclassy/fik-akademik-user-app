import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String idStatus;
  final String alasan_penolakan;
  final String tipeRuang;
  final String grupPengguna;
  final String catatanKejadian;

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
    required this.idStatus,
    required this.alasan_penolakan,
    required this.tipeRuang,
    required this.grupPengguna,
    required this.catatanKejadian,
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

  Future<void> _confirmPeminjaman(String idPeminjaman) async {
  try {
    await confirmPeminjamanStatus(idPeminjaman);
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Peminjaman berhasil dikonfirmasi')),
    );
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => SemuadaftarPage(room: widget.tipeRuang)),
    );
  } catch (e) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Gagal mengkonfirmasi peminjaman')),
    );
    print(e);
  }
}


Future<void> _cancelPeminjaman(String idPeminjaman) async {
  try {
    var response = await batalPeminjaman(idPeminjaman);
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Peminjaman berhasil dibatalkan')),
    );
    Navigator.of(context).pop(true); // Pass true to indicate success
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

  void _showConfirmationPeminjamanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Penggunaan Ruangan'),
          content: Text('Apakah Anda akan menggunakan ruangan?'),
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
                _confirmPeminjaman(widget.idPeminjaman);
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _launchWhatsApp(String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String getStatusString(String idStatus) {
    switch (idStatus) {
      case '4':
        return 'Waiting';
      case '5':
        return 'Rejected';
      case '6':
        return 'Accepted';
      case '7':
        return 'On Going';
      case '8':
        return 'Completed';
      default:
        return 'Unknown';
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
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowWithDivider('ID Transaksi', widget.idPeminjaman),
            buildRowWithDivider('Status', getStatusString(widget.idStatus)),
            buildRowWithDivider('Nama', widget.studentName),
            buildRowWithDivider('Ruangan', widget.ruangan),
            buildRowWithDivider('Tipe Ruangan', widget.tipeRuang),
            buildRowWithDivider('Grup Pengguna', widget.grupPengguna),
            buildRowWithDivider('Tgl Pinjam', widget.bookDate),
            buildRowWithDivider('Jam Mulai', widget.jamMulai),
            buildRowWithDivider('Jam Selesai', widget.jamSelesai),
            buildRowWithDivider('Jml Pengguna', widget.jumlahPengguna),
            buildRowWithDivider('Keterangan', widget.keterangan),
            buildRowWithDivider('Catatan Kejadian', widget.catatanKejadian),
            GestureDetector(
              onTap: () => _launchWhatsApp('6287876619932'),
              child: RichText(
                text: const TextSpan(
                  text: 'Anda dapat menghubungi admin di nomor ',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: '6287876619932',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: ' jika ditemukan kendala',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            if (widget.idStatus == '6') ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmationPeminjamanDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      backgroundColor: const Color(0xFF2F4858),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Konfirmasi Peminjaman'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.alasan_penolakan,
                style: const TextStyle(fontSize: 14),
              ),
            ],
            if (widget.idStatus == '5') ...[
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
      bottomNavigationBar: widget.idStatus == '4'
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