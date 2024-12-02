import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class AssetDetailPage extends StatefulWidget {
  final String idRuangan;
  final String lab;
  final String kelas;

  const AssetDetailPage({super.key, required this.idRuangan, required this.lab, required this.kelas});

  @override
  _AssetDetailPageState createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  late Future<Map<String, dynamic>> _assetDetailsFuture;

  @override
  void initState() {
    super.initState();
    _assetDetailsFuture = api_data.getAssetDetails(widget.idRuangan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Asset Details',
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: _assetDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No asset details found.'));
          } else {
            final assetDetails = snapshot.data!;
            final assets = assetDetails['aset'] as List<dynamic>;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assetDetails['nama_ruangan'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Gedung: ${assetDetails['gedung']}'),
                  Text('Tipe Ruang: ${assetDetails['tipe_ruang']}'),
                  Text('Jam Buka: ${assetDetails['jam_buka']}'),
                  Text('Jam Tutup: ${assetDetails['jam_tutup']}'),
                  Text('Kapasitas: ${assetDetails['kapasitas']}'),
                  const SizedBox(height: 20),
                  const Text(
                    'Daftar Aset',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: assets.length,
                      itemBuilder: (context, index) {
                        final asset = assets[index];
                        return ListTile(
                          title: Text(asset['nama_aset']),
                          subtitle: Text('Jumlah: ${asset['jumlah']}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}