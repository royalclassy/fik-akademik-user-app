import 'package:flutter/material.dart';
import 'asset_detail_screen.dart'; // Import the new screen

class LabDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>> labData;

  const LabDetailPage({super.key, required this.labData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorium FIK', style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: ListView.builder(
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
                    child: Image.asset(
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
                          lab['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(lab['description']!, style: const TextStyle(
                            fontSize: 14),),
                        const SizedBox(height: 5),
                        Text('Lantai: ${lab['floor']}'),
                        Text('Ruangan: ${lab['room']}'),
                        Text('Gedung: ${lab['building']}'),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssetDetailPage(lab: lab),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: const Text('Daftar Aset', style: TextStyle(
                                color: Colors.white,
                            fontSize: 14, fontWeight: FontWeight.bold,),),
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
      ),
    );
  }
}