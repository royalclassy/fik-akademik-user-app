import 'package:class_leap/src/screens/welcome/kelas_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:class_leap/src/custom_style/home_card.dart';
import 'package:class_leap/src/screens/welcome/lab_detail_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_lab_screen.dart';
import 'package:class_leap/src/screens/welcome/profile_detail_screen.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/screens/welcome/list_dosen_screen.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

Future<List<Map<String, dynamic>>> _fetchProfiles() async {
  var data = await api_data.getAllProfildosen();
  return List<Map<String, dynamic>>.from(data.map((item) => {
    'nama': item['nama'].toString() ?? 'Unknown',
    'imageUrl': item['image_url'].toString() ?? '',
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
                                builder: (context) => const LabDetailPage(),
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
                                builder: (context) => const KelasDetailPage(),
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
                            MaterialPageRoute(builder: (context) => const JadwallabPage()),
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
                            MaterialPageRoute(builder: (context) => const JadwalkelasPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
                          MaterialPageRoute(builder: (context) => const ListDosenScreen()),
                        );
                      },
                      child: const Text('Lihat Semua'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          profile['imageUrl']?.isNotEmpty ?? false
                                              ? profile['imageUrl']
                                              : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      profile['nama']!,
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
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}