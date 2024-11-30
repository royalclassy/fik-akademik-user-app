import 'package:flutter/material.dart';
// Import BookingCard
// Import dummy data

class MenungguPage extends StatelessWidget {
  const MenungguPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daftar Belum Dikonfirmasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            // BookingCard(
            //   studentName: DummyData.studentName,
            //   inputDate: DummyData.bookDate,
            //   time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
            //   ruangan: DummyData.ruangan,
            //   groupSize: "${DummyData.jumlahPengguna} Orang",
            //   onAccept: () {
            //     // Aksi saat tombol 'Terima' ditekan
            //   },
            //   onReject: () {
            //     // Aksi saat tombol 'Tolak' ditekan
            //   },
            //   status: 'Menunggu', // Add status parameter
            // ),
            SizedBox(height: 16),
            // BookingCard(
            //   studentName: DummyData.studentName,
            //   inputDate: DummyData.bookDate,
            //   time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
            //   ruangan: DummyData.ruangan,
            //   groupSize: "${DummyData.jumlahPengguna} Orang",
            //   onAccept: () {
            //     // Aksi saat tombol 'Terima' ditekan
            //   },
            //   onReject: () {
            //     // Aksi saat tombol 'Tolak' ditekan
            //   },
            //   status: 'Menunggu', // Add status parameter
            // ),
            SizedBox(height: 16),
            // BookingCard(
            //   studentName: DummyData.studentName,
            //   inputDate: DummyData.bookDate,
            //   time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
            //   ruangan: DummyData.ruangan,
            //   groupSize: "${DummyData.jumlahPengguna} Orang",
            //   onAccept: () {
            //     // Aksi saat tombol 'Terima' ditekan
            //   },
            //   onReject: () {
            //     // Aksi saat tombol 'Tolak' ditekan
            //   },
            //   status: 'Menunggu', // Add status parameter
            // ),
          ],
        ),
      ),
    );
  }
}