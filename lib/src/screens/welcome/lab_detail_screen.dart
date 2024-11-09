import 'package:flutter/material.dart';

class LabDetailPage extends StatelessWidget {
  final List<Map<String, String>> labData;

  const LabDetailPage({Key? key, required this.labData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorium FIK', style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: ListView.builder(
        itemCount: labData.length,
        itemBuilder: (context, index) {
          final lab = labData[index];
          return Padding(
            padding: const EdgeInsets.all(8.0), // Add padding here
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(lab['description']!),
                        SizedBox(height: 5),
                        Text('Floor: ${lab['floor']}'),
                        Text('Building: ${lab['building']}'),
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