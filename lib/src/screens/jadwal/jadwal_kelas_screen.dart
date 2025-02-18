import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/jam_card.dart';
import 'package:class_leap/src/custom_style/jadwal_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class JadwalkelasPage extends StatefulWidget {
  const JadwalkelasPage({super.key});

  @override
  _JadwalkelasPageState createState() => _JadwalkelasPageState();
}

class _JadwalkelasPageState extends State<JadwalkelasPage> {
  late Future<List<Map<String, dynamic>>> _jadwalFuture;
  List<Map<String, String>> ruanganList = [];
  String? selectedRoom;
  String? selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = _getDayOfWeek(DateTime.now());
    _jadwalFuture = fetchJadwal();
    getRuangan();
  }

  Future<void> getRuangan() async {
    var data = await api_data.getRuang('kelas');
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
    });
  }

  Future<List<Map<String, dynamic>>> fetchJadwal() async {
    List<Map<String, dynamic>> allJadwal = await api_data.getAllJadwal();
    allJadwal = allJadwal.where((jadwal) => jadwal['tipe_ruang'] == 'kelas').toList();

    if (selectedRoom != null) {
      print("Selected Room: $selectedRoom");
      allJadwal = allJadwal.where((jadwal) => jadwal['id_ruang'] == selectedRoom).toList();
      print("All Jadwal: $allJadwal");
    }
    if (selectedDay != null) {
      print("Selected Day: $selectedDay");
      allJadwal = allJadwal.where((jadwal) => jadwal['hari'] == selectedDay).toList();
      print("All Jadwal: $allJadwal");
    }
    print("All Jadwal: $allJadwal");
    return allJadwal;
  }

  void updateJadwal() {
    setState(() {
      _jadwalFuture = fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Penggunaan Ruang Kelas',
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: (date) {
                      setState(() {
                        selectedDay = _getDayOfWeek(date);
                        updateJadwal(); // Update jadwal when day changes
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Ruang Kelas: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
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
                              value: room['id_ruangan'],
                              child: Text(room['id_ruangan']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoom = newValue;
                              print('Selected Room: $selectedRoom');
                              print('Selected Day: $selectedDay');
                              updateJadwal(); // Update jadwal when room changes
                            });
                          },
                          dropdownColor: const Color(0xFFFFBE33),
                          underline: const SizedBox(),
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
                    return const Center(child: Text('Tidak ada data'));
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
                                namaMatkul: jadwal['namaMatkul'] ?? 'Unknown',
                                kodeMatkul: jadwal['kodeMatkul'] ?? 'Unknown',
                                namaDosen: jadwal['namaDosen'] ?? 'Unknown',
                                kodeDosen: jadwal['kodeDosen'] ?? 'Unknown',
                                ruangan: jadwal['id_ruang'] ?? 'Unknown',
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

  String _getDayOfWeek(DateTime date) {
    List<String> days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return days[date.weekday % 7];
  }
}