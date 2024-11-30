import 'package:class_leap/src/custom_style/bar_chart.dart';
import 'package:class_leap/src/screens/peminjaman/form_pinjam.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/screens/peminjaman/semua_pinjam_screen.dart';

class PeminjamanPage extends StatelessWidget {
  const PeminjamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text(
            'Peminjaman Ruang Lab dan Kelas',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFFF5833),
          iconTheme: const IconThemeData(
            color: Colors.white, // Set all icons to white
          ),
          bottom: const TabBar(
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
                    const Text(
                      'Peminjaman Ruang Lab Komputer FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Pinjam Lab',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PinjamRuang(room: 'lab')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            label: 'Lihat Semua Daftar',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SemuadaftarPage(room: 'lab')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Kepadatan Peminjaman Ruang Lab FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BarChart(room: 'lab', type: 'peminjaman'),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: CardConfirmed(
                    //     studentName: DummyData.studentName,
                    //     studentNim: DummyData.studentNim,
                    //     inputDate: DummyData.bookDate,
                    //     time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                    //     ruangan: DummyData.ruangan,
                    //     groupSize: "${DummyData.jumlahPengguna} Orang",
                    //     isAccepted: true,
                    //     bookDate: '',
                    //     jamMulai: '',
                    //     jamSelesai: '',
                    //     jumlahPengguna: '',
                    //     keterangan: '',
                    //   ),
                    // ),
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
                    const Text(
                      'Peminjaman Ruang Kelas Komputer FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Pinjam Kelas',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PinjamRuang(room: 'kelas')),
                                // MaterialPageRoute(builder: (context) => PinjamRuang()), //kalo jadi disatuin datanya sama yang ruang kelas
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            label: 'Lihat Semua Daftar',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SemuadaftarPage(room: 'kelas')),
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
                    const SizedBox(height: 30),
                    const Text(
                      'Kepadatan Peminjaman Ruang Kelas FIK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BarChart(room: 'kelas', type: 'peminjaman',),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: CardConfirmed(
                    //     studentName: DummyData.studentName,
                    //     studentNim: DummyData.studentNim,
                    //     inputDate: DummyData.bookDate,
                    //     time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                    //     ruangan: DummyData.ruangan,
                    //     groupSize: "${DummyData.jumlahPengguna} Orang",
                    //     isAccepted: true,
                    //     bookDate: '',
                    //     jamMulai: '',
                    //     jamSelesai: '',
                    //     jumlahPengguna: '',
                    //     keterangan: '',
                    //   ),
                    // ),
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