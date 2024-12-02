import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'asset_detail_screen.dart'; // Import the new screen

class KelasDetailPage extends StatefulWidget {
  const KelasDetailPage({super.key});

  @override
  _KelasDetailPageState createState() => _KelasDetailPageState();
}

class _KelasDetailPageState extends State<KelasDetailPage> {
  late Future<List<Map<String, String>>> _kelasDataFuture;

  @override
  void initState() {
    super.initState();
    _kelasDataFuture = getKelasData();
  }

  Future<List<Map<String, String>>> getKelasData() async {
    var data = await api_data.getRuang('kelas');
    return List<Map<String, String>>.from(data.map((item) => {
      'id_ruangan': item['id_ruangan'].toString(),
      'nama_ruangan': item['nama_ruangan'].toString(),
      'imageUrl': item['image_url'].toString(), // Assuming imageUrl is part of the response
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ruang Kelas FIK',
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
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _kelasDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lab data found.'));
          } else {
            final labData = snapshot.data!;
            return ListView.builder(
              itemCount: labData.length,
              itemBuilder: (context, index) {
                final lab = labData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Add padding here
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.network(
                            lab['imageUrl']!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lab['nama_ruangan']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('ID Ruangan: ${lab['id_ruangan']}'),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AssetDetailPage(
                                          idRuangan: lab['id_ruangan']!,
                                          lab: lab['nama_ruangan']!,
                                          kelas: 'some_class', // Replace with actual class if needed
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                  child: const Text(
                                    'Daftar Aset',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}