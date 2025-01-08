import 'package:flutter/material.dart';
import 'package:class_leap/src/screens/peminjaman/detail_peminjaman_screen.dart';

class CardConfirmed extends StatelessWidget {
  final String idPeminjaman;
  final String studentName;
  final String inputDate;
  final String ruangan;
  final bool isAccepted;
  // final String studentNim;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;
  final String time; // Add the time parameter
  final String groupSize;// Add the groupSize parameter
  final String alasanPenolakan;

  const CardConfirmed({
    super.key,
    required this.idPeminjaman,
    required this.studentName,
    required this.inputDate,
    required this.ruangan,
    required this.isAccepted,
    // required this.studentNim,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.time, // Initialize the time parameter
    required this.groupSize, // Initialize the groupSize parameter
    required this.alasanPenolakan
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              idPeminjaman: idPeminjaman,
              studentName: studentName,
              // studentNim: studentNim,
              // inputDate: inputDate,
              ruangan: ruangan,
              tipeRuang: 'kelas',
              bookDate: bookDate,
              jamMulai: jamMulai,
              jamSelesai: jamSelesai,
              jumlahPengguna: jumlahPengguna,
              keterangan: keterangan,
              status: isAccepted? 'Diterima' : 'Ditolak',
              alasan_penolakan: alasanPenolakan,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(inputDate),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 12),
                          Text(time),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_pin),
                          const SizedBox(width: 12),
                          Text(ruangan),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.group),
                          const SizedBox(width: 12),
                          Text(groupSize),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isAccepted ? Colors.green[500] : Colors.red[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isAccepted ? 'Diterima' : 'Ditolak',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}