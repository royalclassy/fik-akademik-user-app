import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/asset_list.dart';

class AssetDetailPage extends StatelessWidget {
  final Map<String, dynamic>? lab;
  final Map<String, dynamic>? kelas;

  const AssetDetailPage({super.key, required this.lab, this.kelas})
  : assert(lab != null || kelas != null, 'Either lab or kelas must be provided');

  @override
  Widget build(BuildContext context) {
    final data = lab ?? kelas!;
    final assets = data['assets'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title'], style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Aset',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ...assets.map<Widget>((asset) => Text(asset)).toList(),
            AssetList(assets: assets),
          ],
        ),
      ),
    );
  }
}