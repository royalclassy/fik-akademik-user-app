import 'package:flutter/material.dart';
import 'package:class_leap/src/screens/welcome/profile_detail_screen.dart';
import 'package:class_leap/src/utils/data/profile_dosen_data.dart';
import 'package:class_leap/src/custom_style/search_bar.dart';

class ListDosenScreen extends StatefulWidget {
  @override
  _ListDosenScreenState createState() => _ListDosenScreenState();
}

class _ListDosenScreenState extends State<ListDosenScreen> {
  String searchQuery = '';
  String selectedJurusan = 'All';

  List<Map<String, String>> get filteredProfiles {
    return profiles.where((profile) {
      final matchesSearch = profile['name']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesJurusan = selectedJurusan == 'All' || profile['jurusan'] == selectedJurusan;
      return matchesSearch && matchesJurusan;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dosen Fakultas Ilmu Komputer',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        iconTheme: IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    onSearch: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedJurusan,
                  onChanged: (value) {
                    setState(() {
                      selectedJurusan = value!;
                    });
                  },
                  items: [
                    'All',
                    'S1 Informatika',
                    'S1 Sistem Informasi',
                    'D3 Sistem Informasi',
                    'S1 Sains Data',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: filteredProfiles.length,
              itemBuilder: (context, index) {
                final profile = filteredProfiles[index];
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
                          googlescholar: profile['googlescholar'] ?? 'Unknown',
                          sinta: profile['sinta'] ?? 'Unknown',
                          scopus: profile['scopus'] ?? 'Unknown',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profile['imageUrl']!),
                      ),
                      SizedBox(height: 10),
                      Text(
                        profile['name']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}