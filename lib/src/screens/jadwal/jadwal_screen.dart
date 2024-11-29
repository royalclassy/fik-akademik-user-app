// lib/src/screens/jadwal/jadwal_screen.dart
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_leap/src/custom_style/home_card.dart';
import 'package:class_leap/src/screens/welcome/lab_detail_screen.dart';
import 'package:class_leap/src/utils/data/lab_data.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/screens/jadwal/kode_dosen_mk_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_lab_screen.dart';
import 'package:class_leap/src/screens/welcome/profile_detail_screen.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/custom_style/custom_button_two.dart';
import 'package:class_leap/src/utils/data/profile_dosen_data.dart';
import 'package:class_leap/src/screens/welcome/list_dosen_screen.dart';
import 'package:class_leap/src/screens/welcome/kelas_detail_screen.dart';
import 'package:class_leap/src/utils/data/kelas_data.dart';


class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwalPage> {
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
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Jadwal Ruang Lab dan Kelas FIK UPNVJ',
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                      child: Text('Lihat Semua'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: profiles.take(4).map((profile) {
                      return GestureDetector(
                        onTap: () {
                          if (profile['id'] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfiledetailPage(
                                  id: profile['id']!,
                                  name: profile['name']!,
                                  imageUrl: profile['imageUrl']!,
                                  NIP: profile['NIP']!,
                                  NIDN: profile['NIDN']!,
                                  email: profile['email']!,
                                  jabatan: profile['jabatan']!,
                                  jabatanFungsi: profile['jabatanFungsi']!,
                                  keahlian: profile['keahlian']!,
                                  googlescholar: profile['googlescholar']!,
                                  sinta: profile['sinta']!,
                                  scopus: profile['scopus']!,
                                ),
                              ),
                            );
                          }
                          else {
                            print('Profile ID is null');
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProfiledetailPage(
                          //       name: profile['name']!,
                          //       imageUrl: profile['imageUrl']!,
                          //       NIP: profile['NIP']!,
                          //       email: profile['email']!,
                          //       jabatan: profile['jabatan']!,
                          //       jabatanFungsi: profile['jabatanFungsi']!,
                          //       keahlian: profile['keahlian']!,
                          //       googlescholar: profile['googlescholar']!,
                          //       sinta: profile['sinta']!,
                          //       scopus: profile['scopus']!,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(profile['imageUrl']!),
                              ),
                              SizedBox(height: 5),
                              Text(
                                profile['name']!,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
