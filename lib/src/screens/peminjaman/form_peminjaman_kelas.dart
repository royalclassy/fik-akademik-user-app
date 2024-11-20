import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PinjamKelas extends StatefulWidget {
  @override
  _PinjamKelasState createState() => _PinjamKelasState();
}

class _PinjamKelasState extends State<PinjamKelas> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRoom;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int? _numberOfParticipants;
  String? _purpose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Peminjaman Kelas',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                        items: [
                          'KHD 201', 'KHS 202', 'KHS 203', 'DS 201', 'DS 202', 'DS 203',
                          'DS 301', 'DS 302', 'DS 303', 'DS 401', 'DS 402', 'DS 403'
                        ].map((room) {
                          return DropdownMenuItem(
                            value: room,
                            child: Text(room),
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
                              if (_formKey.currentState?.validate() ?? false) {
                                // Process the form submission
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