import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/screens/jadwal/kode_dosen_mk_screen.dart';
import 'package:class_leap/src/screens/welcome/kelas_detail_screen.dart';
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_leap/src/custom_style/home_card.dart';
import 'package:class_leap/src/screens/welcome/lab_detail_screen.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/custom_style/custom_button_two.dart';

class JadwallabPage extends StatefulWidget {
  const JadwallabPage({Key? key}) : super(key: key);

  @override
  State<JadwallabPage> createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwallabPage> {
  final List<Map<String, String>> labData = [
    {
      'imageUrl': 'assets/images/lab_ai.png',
      'title': 'Laboratorium AI',
      'description': 'Description for AI Lab',
      'floor': '1st Floor',
      'building': 'Building A',
    },
    {
      'imageUrl': 'assets/images/lab_ai.png',
      'title': 'Laboratorium TES',
      'description': 'Description for AI Lab',
      'floor': '1st Floor',
      'building': 'Building B',
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
                        onPressed: () {},
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