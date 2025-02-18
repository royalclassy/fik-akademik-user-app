import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '';

class ProfiledetailPage extends StatelessWidget {
  final String id_prodi;
  final String name;
  final String imageUrl;
  final String NIP;
  final String NIDN;
  final String email;
  final String jabatan;
  final String jabatanFungsi;
  final String keahlian;
  final String googlescholar;
  final String sinta;
  final String scopus;

  const ProfiledetailPage({
    super.key,
    required this.id_prodi,
    required this.name,
    required this.imageUrl,
    required this.NIP,
    required this.NIDN,
    required this.email,
    required this.jabatan,
    required this.jabatanFungsi,
    required this.keahlian,
    required this.googlescholar,
    required this.sinta,
    required this.scopus,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Tidak dapat launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        )),
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
            Center(
              child: CircleAvatar(
                radius: 80,
                // backgroundImage: Image.network(profile ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png').image,
                backgroundImage: imageUrl.isNotEmpty ?? false
                    ? NetworkImage(imageUrl)
                    : const AssetImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Table(
              columnWidths: const {
                0: FixedColumnWidth(160.0),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Id prodi:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(id_prodi, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('NIP:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(NIP, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('NIDN:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(NIDN, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Email:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () => _launchURL('mailto:$email'),
                        child: Text(email, style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Jabatan:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(jabatan, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Jabatan Fungsi:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(jabatanFungsi, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Kepakaran:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(keahlian, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Google Scholar:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: (googlescholar == null || googlescholar.contains('-') || googlescholar == 'null')
                          ? Text(googlescholar ?? 'Unknown', style: const TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://scholar.google.com/citations?user=$googlescholar'),
                        child: Text(googlescholar, style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID SINTA:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: (sinta == null || sinta.contains('-') || sinta == 'null')
                          ? Text(sinta ?? 'Unknown', style: const TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://sinta.kemdikbud.go.id/authors/profile/$sinta'),
                        child: Text(sinta, style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Scopus:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: (scopus == null || scopus.contains('-') || scopus == 'null')
                          ? Text(scopus ?? 'Unknown', style: const TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://www.scopus.com/authid/detail.uri?authorId=$scopus'),
                        child: Text(scopus, style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
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