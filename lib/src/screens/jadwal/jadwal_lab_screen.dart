import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/jam_card.dart';
import 'package:class_leap/src/custom_style/jadwal_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class JadwallabPage extends StatefulWidget {
  const JadwallabPage({super.key});

  @override
  _JadwallabPageState createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwallabPage> {
  late Future<List<Map<String, dynamic>>> _jadwalFuture;
  List<Map<String, String>> ruanganList = [];
  String? selectedRoom;

  @override
  void initState() {
    super.initState();
    _jadwalFuture = fetchJadwal();
    getRuangan();
  }

  Future<void> getRuangan() async {
    var data = await api_data.getRuang('lab');
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
    });
  }

  Future<List<Map<String, dynamic>>> fetchJadwal([String? room]) async {
    List<Map<String, dynamic>> allJadwal = await api_data.getAllJadwal();
    allJadwal = allJadwal.where((jadwal) => jadwal['tipe_ruang'] == 'lab').toList();
    if (room != null) {
      print(room);
      allJadwal = allJadwal.where((jadwal) => jadwal['ruangan'] == room).toList();
    }
    return allJadwal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Penggunaan Ruang Lab',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Ruang Lab: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0x99FF5833),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton<String>(
                                value: selectedRoom,
                                hint: const Text("Pilih", style: TextStyle(color: Colors.white)),
                                items: ruanganList.map((room) {
                                  return DropdownMenuItem(
                                    value: room['nama_ruangan'],
                                    child: Text(room['nama_ruangan']!),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedRoom = newValue;
                                    _jadwalFuture = fetchJadwal(selectedRoom);
                                  });
                                },
                                dropdownColor: const Color(0xFFFFBE33),
                                underline: const SizedBox(),
                                style: const TextStyle(color: Colors.white),
                                isExpanded: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xFFFF5833),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _jadwalFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
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
                              const SizedBox(width: 10),
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