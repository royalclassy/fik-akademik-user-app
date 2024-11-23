import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/screens/jadwal/kode_dosen_mk_screen.dart';
import 'package:class_leap/src/screens/welcome/kelas_detail_screen.dart';
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_lab_screen.dart';
import 'package:class_leap/src/screens/welcome/profile_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_leap/src/custom_style/home_card.dart';
import 'package:class_leap/src/screens/welcome/lab_detail_screen.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/custom_style/custom_button_two.dart';
import 'package:class_leap/src/utils/data/profile_dosen_data.dart';
import 'package:class_leap/src/screens/welcome/list_dosen_screen.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwalPage> {
  final List<Map<String, String>> labData = [
    {
      'imageUrl': 'assets/images/sekret_lab.png',
      'title': 'Sekretariat Laboratorium',
      'description': 'Ruangan Sekretariat Laboratorium yang berfungsi sebagai pusat administrasi dan koordinasi kegiatan laboratorium.',
      'floor': '3',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_program.png',
      'title': 'Laboratorium Programming',
      'description': 'Pusat praktikum dan penelitian di bidang pemrograman komputer, dilengkapi dengan komputer terbaru, jaringan internet berkecepatan tinggi, proyektor, dan papan tulis digital untuk mendukung proses belajar mengajar.',
      'floor': '3',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_cs.png',
      'title': 'Laboratorium Cyber Security',
      'description': 'Pusat kegiatan praktikum dan penelitian di bidang keamanan siber, dilengkapi dengan perangkat keras canggih, perangkat lunak keamanan terkini, serta jaringan simulasi serangan siber.',
      'floor': '3',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_data.png',
      'title': 'Laboratorium Data Mining dan Data Science',
      'description': 'Pusat kegiatan praktikum dan penelitian dalam bidang penambangan data dan ilmu data, dilengkapi dengan komputer berkinerja tinggi, perangkat lunak analisis data terkini, dan fasilitas big data.',
      'floor': '3',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_ai.png',
      'title': 'Laboratorium Artificial Intelligence',
      'description': 'Pusat praktikum dan penelitian dalam bidang kecerdasan buatan, dilengkapi dengan komputer berperforma tinggi, perangkat lunak AI terbaru, serta fasilitas pengolahan data besar (big data) dan machine learning.',
      'floor': '3',
      'room': '403',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_bi.png',
      'title': 'Laboratorium Business Intelligence',
      'description': 'Pusat praktikum dan penelitian dalam bidang intelijen bisnis, dilengkapi dengan komputer berperforma tinggi, perangkat lunak analitik terkini, dan platform visualisasi data untuk mendukung pengambilan keputusan bisnis.',
      'floor': '3',
      'room': '403',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_database.png',
      'title': 'Laboratorium Database',
      'description': 'Pusat praktikum dan penelitian dalam bidang manajemen basis data, dilengkapi dengan komputer berperforma tinggi, perangkat lunak database terkini seperti SQL Server, Oracle, dan MySQL, serta fasilitas untuk pengolahan data besar.',
      'floor': '3',
      'room': '403',
      'building': 'Ki Hajar Dewantara',
    },
    {
      'imageUrl': 'assets/images/lab_iot.png',
      'title': 'Laboratorium Internet of Things',
      'description': 'Pusat kegiatan praktikum dan penelitian dalam bidang teknologi IoT, dilengkapi dengan perangkat keras canggih seperti sensor, mikrokontroler, dan modul komunikasi nirkabel, serta perangkat lunak pengembangan IoT terkini.',
      'floor': '3',
      'room': '403',
      'building': 'Ki Hajar Dewantara',
    },
    // Add more lab data as needed
  ];

  final List<Map<String, String>> kelasData = [
    {
      'imageUrl': 'assets/images/kelas.png',
      'title': 'Ruang Kelas 101',
      'description': 'Description for Classroom 101',
      'floor': '1st Floor',
      'building': 'Building C',
    },
    // Add more classroom data as needed
  ];

//   final List<Map<String, String>> profiles = [
//   {
//     'name': 'Dr. Widya Cholil, M.I.T ',
//     'imageUrl': 'https://new-fik.upnvj.ac.id/wp-content/uploads/2024/05/widya.png',
//   },
//   {
//   'name': 'Dr. Eng. Rizal Broer Bahaweres',
//   'imageUrl': 'https://example.com/jane.jpg',
//   },
// ];

  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      items: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LabDetailPage(labData: labData),
                              ),
                            );
                          },
                          child: const HomeCard(
                            imageUrl: 'assets/images/lab_ai.png',
                            title: 'Laboratorium FIK',
                            // fontSize: _currentIndex == 0 ? 14 : 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KelasDetailPage(kelasData: kelasData),
                              ),
                            );
                          },
                          child: const HomeCard(
                            imageUrl: 'assets/images/kelas.png',
                            title: 'Ruang Kelas FIK',
                            // fontSize: _currentIndex == 1 ? 14 : 14,
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        // onPageChanged: (index, reason) {
                        //   setState(() {
                        //     _currentIndex = index;
                        //   });
                        // },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Jadwal Ruang Lab dan Kelas FIK UPNVJ',
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
                        label: 'Jadwal Ruang Lab',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JadwallabPage()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        label: 'Jadwal Ruang Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JadwalkelasPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButtonTwo(
                        label: 'Jadwal KRSku',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KodedosenmkPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Data Dosen',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListDosenScreen()),
                        );
                      },
                      child: const Text('Lihat Semua'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: profiles.take(4).map((profile) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfiledetailPage(
                                name: profile['name']!,
                                imageUrl: profile['imageUrl']!,
                                NIP: profile['NIP']!,
                                email: profile['email']!,
                                jabatan: profile['jabatan']!,
                                keahlian: profile['keahlian']!,
                                googlescholar: profile['googlescholar']!,
                                sinta: profile['sinta']!,
                                scopus: profile['scopus']!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(profile['imageUrl']!),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                profile['name']!,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}