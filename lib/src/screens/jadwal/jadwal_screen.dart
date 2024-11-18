import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/screens/jadwal/kode_dosen_mk_screen.dart';
import 'package:class_leap/src/screens/welcome/kelas_detail_screen.dart';
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_lab_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_leap/src/custom_style/home_card.dart';
import 'package:class_leap/src/screens/welcome/lab_detail_screen.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/custom_style/custom_button_two.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
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
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pemakaian Ruang Lab dan Kelas FIK UPNVJ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
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
                          child: HomeCard(
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
                          child: HomeCard(
                            imageUrl: 'assets/images/kelas.png',
                            title: 'Ruang Kelas FIK',
                            // fontSize: _currentIndex == 1 ? 14 : 14,
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 240,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 10),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                SizedBox(height: 20),
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
                    SizedBox(width: 10),
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
                SizedBox(height: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}