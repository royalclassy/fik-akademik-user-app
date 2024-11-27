import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'semua_pinjam_screen.dart'; // Import the screen to navigate to

class PinjamRuang extends StatefulWidget {
  final String room;

  const PinjamRuang({super.key, required this.room});

  @override
  _PinjamRuangState createState() => _PinjamRuangState();
}

class _PinjamRuangState extends State<PinjamRuang> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  List<Map<String, String>> ruanganList = [];
  String? _selectedRoom;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int? _numberOfParticipants;
  String? _purpose;
  String? message;
  bool? isAvailable;
  // String? userId;

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
    // _fetchUserData();
  }

  // Future<void> _fetchUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userId = prefs.getString('nim');
  //   print('User ID: $userId');
  // }

  Future<void> getRuangan() async {
    var data = await getRuang(widget.room);
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
        // 'type': item['type'].toString(),
      }));
    });
  }

  Future<Map<int, String>> _submitForm() async {
    final Map<int, String> response = await addPeminjaman(
      // userId!,
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
  var availabilityResponse = await getAvailablity(
    _dateController.text,
    _startTimeController.text,
    _endTimeController.text,
    _selectedRoom!,
    _participantsController.text,
  );
  bool availability = availabilityResponse['available'];
  String message = availabilityResponse['message'];

  print('Availability: $availability');
  print('Message: $message');
  if (availability) {
    final Map<int, String> response = await _submitForm();
    if (response.isNotEmpty) {
      _showResultDialog(true, response[200] ?? 'Unknown error');
    } else {
      _showResultDialog(false, response[200] ?? 'Unknown error');
    }
  } else {
    _showResultDialog(false, message);
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
              child: const Text('Kembali'),
            ),
            if (success)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SemuadaftarPage(room: widget.room,)),
                  );

                    _formKey.currentState?.reset();
                    _dateController.clear();
                    _startTimeController.clear();
                    _endTimeController.clear();
                    _participantsController.clear();
                    _purposeController.clear();
                    setState(() {
                    _selectedRoom = null;
                    _selectedDate = null;
                    _startTime = null;
                    _endTime = null;
                    _numberOfParticipants = null;
                    _purpose = null;
                    });
                  // Navigator.push(
                    // context,
                    // MaterialPageRoute(builder: (context) => SemuadaftarPage()),
                  // );
                },
                child: const Text('Lihat Semua Daftar'),
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
        title: const Text('Pinjam Ruang', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFFFFFFFF),
        ),),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
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
                      const Text('Ruangan', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
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
                      const SizedBox(height: 20),
                      const Text('Tanggal Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _selectedDate == null
                              ? 'Pilih tanggal'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          hintStyle: const TextStyle(fontSize: 14),
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
                      const SizedBox(height: 20),
                      const Text('Waktu Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _startTime == null
                              ? 'Pilih waktu mulai'
                              : _startTime!.format(context),
                          hintStyle: const TextStyle(fontSize: 14),
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
                      const SizedBox(height: 20),
                      const Text('Waktu Selesai', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _endTime == null
                              ? 'Pilih waktu selesai'
                              : _endTime!.format(context),
                          hintStyle: const TextStyle(fontSize: 14),
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
                      const SizedBox(height: 20),
                      const Text('Jumlah Peserta', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _participantsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
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
                      const SizedBox(height: 20),
                      const Text('Tujuan Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _purposeController,
                        decoration: const InputDecoration(
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _testAvailability();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              backgroundColor: const Color(0xFF2F4858), // Set the button color here
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Kirim',
                              style: TextStyle(fontWeight: FontWeight.w600),
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