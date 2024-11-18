import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/jam_card.dart';
import 'package:class_leap/src/custom_style/jadwal_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class JadwalkelasPage extends StatefulWidget {
  @override
  _JadwalkelasPageState createState() => _JadwalkelasPageState();
}

class _JadwalkelasPageState extends State<JadwalkelasPage> {
  late Future<List<Map<String, dynamic>>> _jadwalFuture;
  String? selectedRoom;

  @override
  void initState() {
    super.initState();
    _jadwalFuture = fetchJadwal();
  }

  Future<List<Map<String, dynamic>>> fetchJadwal() async {
    List<Map<String, dynamic>> allJadwal = await api_data.getAllJadwal();
    return allJadwal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Penggunaan Ruang Lab',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyDateTimeLine(initialDate: DateTime.now()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ruang Lab: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0x99FF5833),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton<String>(
                                value: selectedRoom,
                                hint: Text("Pilih", style: TextStyle(color: Colors.white)),
                                items: [
                                  DropdownMenuItem(
                                    value: "KHD 301",
                                    child: Text("KHD 301 Lab Programming", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 302",
                                    child: Text("KHD 302 Lab Cybersecurity", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 303",
                                    child: Text("KHD 303 Lab Data Mining dan Data Science", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 304",
                                    child: Text("KHD 304 Lab Artificial Intelligence", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 401",
                                    child: Text("KHD 401 Lab Business Intelligence", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 402",
                                    child: Text("KHD 402 Lab Database", style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: "KHD 403",
                                    child: Text("KH3 402 Lab Internet of Things", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedRoom = newValue;
                                  });
                                },
                                dropdownColor: Color(0xFFFFBE33),
                                underline: SizedBox(),
                                style: TextStyle(color: Colors.white),
                                isExpanded: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xFFFF5833),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _jadwalFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<Map<String, dynamic>> jadwalList = snapshot.data!;
                    return ListView.builder(
                      itemCount: jadwalList.length,
                      itemBuilder: (context, index) {
                        var jadwal = jadwalList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              JamCard(
                                jamMulai: jadwal['jamMulai']!,
                                jamSelesai: jadwal['jamSelesai']!,
                              ),
                              SizedBox(width: 10),
                              JadwalCard(
                                namaMatkul: jadwal['namaMatkul']!,
                                kodeMatkul: jadwal['kodeMatkul']!,
                                namaDosen: jadwal['namaDosen']!,
                                kodeDosen: jadwal['kodeDosen']!,
                                ruangan: jadwal['ruangan']!,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}