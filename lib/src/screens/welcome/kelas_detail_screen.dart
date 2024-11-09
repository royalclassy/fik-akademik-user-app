import 'package:flutter/material.dart';

class KelasDetailPage extends StatelessWidget {
  final List<Map<String, String>> kelasData;

  const KelasDetailPage({Key? key, required this.kelasData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruang Kelas FIK'),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: ListView.builder(
        itemCount: kelasData.length,
        itemBuilder: (context, index) {
          final kelas = kelasData[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.asset(
                    kelas['imageUrl']!,
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
                        kelas['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(kelas['description']!),
                      SizedBox(height: 5),
                      Text('Floor: ${kelas['floor']}'),
                      Text('Building: ${kelas['building']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}