import 'package:class_leap/src/custom_style/bar_chart.dart';
import 'package:class_leap/src/screens/pelaporan/form_pelaporan_kelas.dart';
import 'package:class_leap/src/screens/pelaporan/form_pelaporan_lab.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/custom_button_one.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_baru_screen.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_dikerjakan_screen.dart';
import 'package:class_leap/src/screens/pelaporan/kendala_selesai_screen.dart';
import 'package:class_leap/src/screens/pelaporan/detail_kendala_screen.dart';
import 'package:class_leap/src/screens/pelaporan/semua_kendala_screen.dart';
import 'package:class_leap/src/custom_style/card_confirmed.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';


class PelaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: Text(
            'Pelaporan Ruangan',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFFFF5833),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
            ),
            tabs: [
              Tab(text: 'Ruang Lab'),
              Tab(text: 'Ruang Kelas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Ruang Lab
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pelaporan Ruang Lab Komputer FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Lapor Lab',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LaporLab()),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            label: 'Semua Kendala Labmu',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SemuakendalaPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Jumlah Pelaporan Ruang Lab FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    BarChart(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CardConfirmed(
                        studentName: DummyData.studentName,
                        studentNim: DummyData.studentNim,
                        inputDate: DummyData.bookDate,
                        time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                        ruangan: DummyData.ruangan,
                        groupSize: "${DummyData.jumlahPengguna} orang",
                        isAccepted: true,
                        bookDate: '',
                        jamMulai: '',
                        jamSelesai: '',
                        jumlahPengguna: '',
                        keterangan: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content for Ruang Kelas
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pelaporan Ruang Kelas Komputer FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Lapor Kelas',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LaporKelas()),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            label: 'Semua Kendala Kelasmu',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SemuakendalaPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: CustomButtonTwo(
                    //     label: 'Lihat Semua Daftar',
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => SemuadaftarPage()),
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    Text(
                      'Jumlah Pelaporan Ruang Kelas FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    BarChart(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CardConfirmed(
                        studentName: DummyData.studentName,
                        studentNim: DummyData.studentNim,
                        inputDate: DummyData.bookDate,
                        time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                        ruangan: DummyData.ruangan,
                        groupSize: "${DummyData.jumlahPengguna} orang",
                        isAccepted: true,
                        bookDate: '',
                        jamMulai: '',
                        jamSelesai: '',
                        jumlahPengguna: '',
                        keterangan: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}