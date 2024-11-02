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
  TimeOfDay? _selectedTime;
  int? _numberOfParticipants;
  String? _purpose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Peminjaman Kelas',
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
                      Text('Ruangan'),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Pilih ruangan',
                          hintStyle: TextStyle(fontSize: 14), // Smaller hint text
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
                      Text('Tanggal Peminjaman'),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _selectedDate == null
                              ? 'Pilih tanggal'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          hintStyle: TextStyle(fontSize: 14), // Smaller hint text
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
                            return 'Tanggal Peminjaman tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Waktu Peminjaman'),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _selectedTime == null
                              ? 'Pilih waktu'
                              : _selectedTime!.format(context),
                          hintStyle: TextStyle(fontSize: 14), // Smaller hint text
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _selectedTime = pickedTime;
                            });
                          }
                        },
                        validator: (value) {
                          if (_selectedTime == null) {
                            return 'Waktu peminjaman tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Jumlah Peserta'),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Masukkan jumlah peserta',
                          hintStyle: TextStyle(fontSize: 14), // Smaller hint text
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
                      Text('Tujuan Peminjaman'),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan tujuan peminjaman',
                          hintStyle: TextStyle(fontSize: 14), // Smaller hint text
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
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
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