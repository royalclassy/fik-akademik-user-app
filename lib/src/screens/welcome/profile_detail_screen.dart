import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfiledetailPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String NIP;
  final String keahlian;
  final String email;
  final String jabatan;
  final String googlescholar;
  final String sinta;
  final String scopus;

  const ProfiledetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.NIP,
    required this.keahlian,
    required this.email,
    required this.jabatan,
    required this.googlescholar,
    required this.sinta,
    required this.scopus,
  });

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: TextStyle(
          fontSize: 18,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Color(0xFFFF5833),
        iconTheme: IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Table(
              columnWidths: {
                0: FixedColumnWidth(160.0),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('NIP/NIDN:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(NIP, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Email:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () => _launchURL('mailto:$email'),
                        child: Text(email, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Jabatan:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(jabatan, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Keahlian:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(keahlian, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Google Scholar:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: googlescholar.contains('-')
                          ? Text(googlescholar, style: TextStyle(fontSize: 14))
                          : InkWell(
                              onTap: () => _launchURL('https://scholar.google.com/citations?user=$googlescholar'),
                              child: Text(googlescholar, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                            ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID SINTA:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: sinta.contains('-')
                          ? Text(sinta, style: TextStyle(fontSize: 14))
                          : InkWell(
                              onTap: () => _launchURL('https://sinta.kemdikbud.go.id/authors/profile/$sinta'),
                              child: Text(sinta, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                            ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Scopus:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: scopus.contains('-')
                          ? Text(scopus, style: TextStyle(fontSize: 14))
                          : InkWell(
                              onTap: () => _launchURL('https://www.scopus.com/authid/detail.uri?authorId=$scopus'),
                              child: Text(scopus, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}