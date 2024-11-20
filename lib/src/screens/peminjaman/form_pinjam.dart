import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'semua_pinjam_screen.dart'; // Import the screen to navigate to

class PinjamRuang extends StatefulWidget {
  @override
  _PinjamRuangState createState() => _PinjamRuangState();
}

class _PinjamRuangState extends State<PinjamRuang> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _roomController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _participantsController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  List<Map<String, String>> ruanganList = [];
  String? _selectedRoom;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int? _numberOfParticipants;
  String? _purpose;
  String? message;
  bool? isAvailable;
  String? userId;

  @override
  void dispose() {
    _roomController.dispose();
    _userController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _participantsController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getRuangan();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('nim');
    print('User ID: $userId');
  }

  Future<void> getRuangan() async {
    var data = await getRuang();
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
        'type': item['type'].toString(),
      }));
    });
  }

  Future<Map<int, String>> _submitForm() async {
    Map<int, String> response = await addPeminjaman(
      userId!,
      _selectedRoom!,
      _dateController.text,
      _startTimeController.text,
      _endTimeController.text,
      _purposeController.text,
      _participantsController.text,
    );
    return response;
  }

  Future<void> _testAvailability() async {
    bool availability = await getAvailablity(
      _dateController.text,
      _startTimeController.text,
      _endTimeController.text,
      _selectedRoom!,
    );
    print('Availability: $availability');
    if (availability) {
      Map<int, String> response = await _submitForm();
      _showResultDialog(response.containsKey(200), response[200] ?? 'Unknown error');
    } else {
      _showResultDialog(false, 'Ruangan tidak tersedia');
    }
  }

  void _showResultDialog(bool success, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Error'),
          content: Text(success ? 'Pengajuanmu sedang diproses!' : message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Kembali'),
            ),
            if (success)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SemuadaftarPage()),
                  );
                },
                child: Text('Lihat Semua Daftar'),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjam Ruang', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFFFFFFFF),
        ),),
        backgroundColor: Color(0xFFFF5833),
        iconTheme: IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ruangan', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Pilih ruangan',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        value: _selectedRoom,
                        items: ruanganList.map((room) {
                          return DropdownMenuItem(
                            value: room['id_ruangan'],
                            child: Text(room['nama_ruangan']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRoom = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ruangan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Tanggal Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _selectedDate == null
                              ? 'Pilih tanggal'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        validator: (value) {
                          if (_selectedDate == null) {
                            return 'Tanggal peminjaman tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Waktu Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _startTime == null
                              ? 'Pilih waktu mulai'
                              : _startTime!.format(context),
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _startTime = pickedTime;
                              _startTimeController.text = pickedTime.format(context);
                            });
                          }
                        },
                        validator: (value) {
                          if (_startTime == null) {
                            return 'Waktu mulai tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Waktu Selesai', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _endTime == null
                              ? 'Pilih waktu selesai'
                              : _endTime!.format(context),
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _endTime = pickedTime;
                              _endTimeController.text = pickedTime.format(context);
                            });
                          }
                        },
                        validator: (value) {
                          if (_endTime == null) {
                            return 'Waktu selesai tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Jumlah Peserta', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _participantsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Masukkan jumlah peserta',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _numberOfParticipants = int.tryParse(value);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah peserta tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Jumlah peserta harus berupa angka';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Tujuan Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _purposeController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan tujuan peminjaman',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _purpose = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tujuan peminjaman tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _testAvailability();
                              }
                            },
                            child: Text(
                              'Kirim',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              backgroundColor: Color(0xFF2F4858), // Set the button color here
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}