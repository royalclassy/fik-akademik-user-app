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
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

Future<List<Map<String, dynamic>>> _fetchProfiles() async {
  var data = await api_data.getAllProfildosen();
  return List<Map<String, dynamic>>.from(data.map((item) => {
    'nama': item['nama'].toString() ?? 'Unknown',
    'imageurl': item['imageurl'].toString() ?? '',
    'NIP': item['nip'].toString() ?? 'Unknown',
    'NIDN': item['nidn'].toString() ?? 'Unknown',
    'email': item['email'].toString() ?? 'Unknown',
    'jabatan': item['jabatan'].toString() ?? 'Unknown',
    'jabatan_fungsi': item['jabatan_fungsi'].toString() ?? 'Unknown',
    'kepakaran': item['kepakaran'].toString() ?? 'Unknown',
    'id_gscholar': item['id_gscholar'].toString() ?? 'Unknown',
    'id_sinta': item['id_sinta'].toString() ?? 'Unknown',
    'id_scopus': item['id_scopus'].toString() ?? 'Unknown',
    'id_prodi': item['id_prodi'].toString() ?? 'Unknown',
  }));
}
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
                            imageUrl: 'assets/images/kelas_302.png',
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Expanded(
                //       child: CustomButtonTwo(
                //         label: 'Jadwal KRSku',
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => KodedosenmkPage()),
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20),
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
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchProfiles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No profiles found.'));
                    } else {
                      final profiles = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: profiles.take(4).map((profile) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfiledetailPage(
                                      id_prodi: profile['id_prodi'] ?? 'Unknown',
                                      name: profile['nama'] ?? 'Unknown',
                                      imageUrl: profile['imageurl'] ?? "",
                                      NIP: profile['NIP'] ?? 'Unknown',
                                      NIDN: profile['NIDN'] ?? 'Unknown',
                                      email: profile['email'] ?? 'Unknown',
                                      jabatan: profile['jabatan'] ?? 'Unknown',
                                      jabatanFungsi: profile['jabatan_fungsi'] ?? 'Unknown',
                                      keahlian: profile['kepakaran'] ?? 'Unknown',
                                      googlescholar: profile['id_gscholar'] ?? 'Unknown',
                                      sinta: profile['id_sinta'] ?? 'Unknown',
                                      scopus: profile['id_scopus'] ?? 'Unknown',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(profile['imageurl']!),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      profile['nama']!,
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
                      );
                    }
                  },
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: profiles.take(4).map((profile) {
                //       return GestureDetector(
                //         onTap: () {
                //           // if (profile['id'] != null) {
                //           //   Navigator.push(
                //           //     context,
                //           //     MaterialPageRoute(
                //           //       builder: (context) => ProfiledetailPage(
                //           //         id: profile['id']!,
                //           //         name: profile['name']!,
                //           //         imageUrl: profile['imageUrl']!,
                //           //         NIP: profile['NIP']!,
                //           //         NIDN: profile['NIDN']!,
                //           //         email: profile['email']!,
                //           //         jabatan: profile['jabatan']!,
                //           //         jabatanFungsi: profile['jabatanFungsi']!,
                //           //         keahlian: profile['keahlian']!,
                //           //         googlescholar: profile['googlescholar']!,
                //           //         sinta: profile['sinta']!,
                //           //         scopus: profile['scopus']!,
                //           //       ),
                //           //     ),
                //           //   );
                //           // }
                //           // else {
                //           //   print('Profile ID is null');
                //           // }
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ProfiledetailPage(
                //                 id: profile['id'] ?? 'Unknown',
                //                 name: profile['name'] ?? 'Unknown',
                //                 imageUrl: profile['imageUrl'] ?? "",
                //                 NIP: profile['NIP'] ?? 'Unknown',
                //                 NIDN: profile['NIDN'] ?? 'Unknown',
                //                 email: profile['email'] ?? 'Unknown',
                //                 jabatan: profile['jabatan'] ?? 'Unknown',
                //                 jabatanFungsi: profile['jabatanFungsi'] ?? 'Unknown',
                //                 keahlian: profile['keahlian'] ?? 'Unknown',
                //                 googlescholar: profile['googlescholar']?? 'Unknown',
                //                 sinta: profile['sinta'] ?? 'Unknown',
                //                 scopus: profile['scopus'] ?? 'Unknown',
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           width: 100,
                //           margin: EdgeInsets.only(right: 10),
                //           child: Column(
                //             children: [
                //               CircleAvatar(
                //                 radius: 40,
                //                 backgroundImage: NetworkImage(profile['imageUrl']!),
                //               ),
                //               SizedBox(height: 5),
                //               Text(
                //                 profile['name']!,
                //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                //                 textAlign: TextAlign.center,
                //                 overflow: TextOverflow.ellipsis,
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
