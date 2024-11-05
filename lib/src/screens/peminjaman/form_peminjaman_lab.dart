import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PinjamLab extends StatefulWidget {
  @override
  _PinjamLabState createState() => _PinjamLabState();
}

class _PinjamLabState extends State<PinjamLab> {
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
  }

  Future<void> getRuangan() async {
    var data = await getRuang();
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
    });
  }

  Future<int> _submitForm() async {
    int response = await addPeminjaman(
      _userController.text,
      _selectedRoom!,
      _dateController.text,
      _startTimeController.text,
      _endTimeController.text,
      _purposeController.text,
      _participantsController.text,
    );
    return response;
  }

  Future<bool> _testAvailability() async {
    bool availability = await getAvailablity(
      _dateController.text,
      _startTimeController.text,
      _endTimeController.text,
      _selectedRoom!,
    );
    if(availability) {
      _submitForm();
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Peminjaman Lab',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
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
                          _numberOfParticipants = int.tryParse(value);
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
                          _purpose = value;
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
                                _testAvailability().then((value) {
                                  if(value) {
                                    setState(() {
                                      message = 'Peminjaman berhasil';
                                    });
                                  }
                                  else {
                                    setState(() {
                                      message = 'Ruangan tidak tersedia';
                                    });
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message ?? ''),
                                  ),
                                );
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