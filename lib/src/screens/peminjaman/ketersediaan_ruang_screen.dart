import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/jam_card.dart';
import 'package:class_leap/src/custom_style/room_card.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

class KetersediaanRuangPage extends StatefulWidget {
  final String room;

  const KetersediaanRuangPage({super.key, required this.room});
  @override
  _KetersediaanRuangPageState createState() => _KetersediaanRuangPageState();
}

class _KetersediaanRuangPageState extends State<KetersediaanRuangPage> {
  late Future<List<Map<String, dynamic>>> _ruangantersediaFuture;
  TextEditingController jamMulaiController = TextEditingController();
  TextEditingController jamSelesaiController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ruangantersediaFuture = fetchRuangantersedia();
  }

  void updateRuangantersedia() {
    setState(() {
      _ruangantersediaFuture = fetchRuangantersedia();
    });
  }

  Future<List<Map<String, dynamic>>> fetchRuangantersedia() async {
    try {
      List<Map<String, dynamic>> allRuangantersedia = await api_data.getRuangTersedia(
        jamMulaiController.text,
        jamSelesaiController.text,
        DateFormat('yyyy-MM-dd').format(selectedDate),
        widget.room,
      );
      print("allRuangantersedia: $allRuangantersedia");
      return allRuangantersedia;
    } catch (e) {
      print("Error fetching ruangan tersedia: $e"); // Debug error
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> fetchRuangantersedia() async {
  //   List<Map<String, dynamic>> allRuangantersedia = await api_data.getAllRuangantersedia(
  //     jamMulaiController.text,
  //     jamSelesaiController.text,
  //     DateFormat('yyyy-MM-dd').format(selectedDate),
  //     'kelas',
  //   );
  //   print("allRuangantersedia: $allRuangantersedia");
  //   return allRuangantersedia;
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        updateRuangantersedia();
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(DateTime(now.year, now.month, now.day, picked.hour, picked.minute));
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ruang Tersedia',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
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
                  Row(
                    children: [
                      Text(
                        'Pilih Tanggal: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildTimePickerRow('Jam Mulai', jamMulaiController),
                  buildTimePickerRow('Jam Selesai', jamSelesaiController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateRuangantersedia,
                    child: Text('Cari'),
                  ),
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
                future: _ruangantersediaFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<Map<String, dynamic>> ruangantersediaList = snapshot.data!;
                    return ListView.builder(
                      itemCount: ruangantersediaList.length,
                      itemBuilder: (context, index) {
                        var ruangantersedia = ruangantersediaList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: RoomCard(
                            idRuang: ruangantersedia['id_ruang'] ?? 'Unknown',
                            namaRuang: ruangantersedia['nama_ruang'] ?? 'Unknown',
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimePickerRow(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 160,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _selectTime(context, controller),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x99FF5833)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x99FF5833)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }
}