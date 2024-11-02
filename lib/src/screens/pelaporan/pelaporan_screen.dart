import 'package:class_leap/src/custom_style/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/custom_button_one.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_baru_screen.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_dikerjakan_screen.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_selesai_screen.dart';
import 'package:class_leap/src/screens/pelaporan/detail_kendala_screen.dart';
import 'package:class_leap/src/screens/pelaporan/semua_kendala_screen.dart';

class PelaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: Text(
          'Pelaporan Kendala/Kerusakan Ruangan',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(4.0), // Height of the bottom border
        //   child: Container(
        //     color: Colors.transparent,
        //     child: Container(
        //       height: 4.0,
        //       decoration: BoxDecoration(
        //         border: Border(
        //           bottom: BorderSide(
        //             color: Color(0xFFFFBE33), // Color of the bottom border
        //             width: 2.0, // Width of the bottom border
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white, // Warna putih untuk konten utama
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks dan elemen lainnya rata kiri
                      children: [
                        Text(
                          'Pelaporan Ruang Lab Komputer FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Baru',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalaBaruPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Laporan Dikerjakan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendaladikerjakanPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Selesai',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalaselesaiPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Semua Laporan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SemuakendalaPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Pelaporan Lab Komputer FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        BarChart(),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Pelaporan Ruang Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Baru',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalaBaruPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Laporan Dikerjakan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendaladikerjakanPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Selesai',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalaselesaiPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Semua Laporan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SemuakendalaPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Pelaporan Ruang Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        BarChart(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}