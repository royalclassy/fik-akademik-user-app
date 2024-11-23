import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class FormPelaporan extends StatefulWidget {
  final String room;

  const FormPelaporan({super.key, required this.room});

  @override
  _FormPelaporanState createState() => _FormPelaporanState();
}

class _FormPelaporanState extends State<FormPelaporan> {
  List<Map<String, String>> ruanganList = [];
  List<Map<String, String>> listJenisKendala = [];
  List<Map<String, String>> listBentukKendala = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedRoom;
  String? _selectedIssueType;
  String? _selectedBentukKendala;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _numberOfParticipants;
  String? _purpose;

  @override
  void initState() {
    super.initState();
    getRuangan();
    getJenisKendala();
    getBentukKendala();
  }

  Future<void> getRuangan() async {
    var data = await api_data.getRuang(widget.room);
    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
    });
  }

  Future<void> getJenisKendala() async {
    var data = await api_data.getJenisKendala();
    setState(() {
      listJenisKendala = List<Map<String, String>>.from(data.map((item) => {
        'id_jenis_kendala': item['id_jenis_kendala'].toString(),
        'nama_jenis_kendala': item['nama_jenis_kendala'].toString(),
      }));
    });
  }

    Future<void> getBentukKendala() async {
    var data = await api_data.getBentukKendala();
    setState(() {
      listBentukKendala = List<Map<String, String>>.from(data.map((item) => {
        'id_bentuk_kendala': item['id_bentuk_kendala'].toString(),
        'nama_bentuk_kendala': item['nama_bentuk_kendala'].toString(),
      }));
    });
  }

    Future<Map<int, String>> _submitForm() async {
    final Map<int, String> response = await api_data.createKendala(
      _selectedRoom!,
      _selectedIssueType ?? '',
      _selectedBentukKendala ?? '',
      _purpose!,
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Pelaporan Kendala Ruangan',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      const Text('Jenis Kendala', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Pilih jenis kendala',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        value: _selectedIssueType,
                        items: listJenisKendala.map((item) {
                          return DropdownMenuItem(
                            value: item['id_jenis_kendala'],
                            child: Text(item['nama_jenis_kendala']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedIssueType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jenis kendala tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Bentuk Kendala', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Pilih bentuk kendala',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        value: _selectedBentukKendala,
                        items: listBentukKendala.map((item) {
                          return DropdownMenuItem(
                            value: item['id_bentuk_kendala'],
                            child: Text(item['nama_bentuk_kendala']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedBentukKendala = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bentuk kendala tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      // SizedBox(height: 20),
                      // Text('Waktu Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
                      // TextFormField(
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     hintText: _selectedTime == null
                      //         ? 'Pilih waktu'
                      //         : _selectedTime!.format(context),
                      //     hintStyle: TextStyle(fontSize: 14),
                      //   ),
                      //   onTap: () async {
                      //     TimeOfDay? pickedTime = await showTimePicker(
                      //       context: context,
                      //       initialTime: TimeOfDay.now(),
                      //     );
                      //     if (pickedTime != null) {
                      //       setState(() {
                      //         _selectedTime = pickedTime;
                      //       });
                      //     }
                      //   },
                      //   validator: (value) {
                      //     if (_selectedTime == null) {
                      //       return 'Waktu peminjaman tidak boleh kosong';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(height: 20),
                      // Text('Kode Perangkat', style: TextStyle(fontWeight: FontWeight.bold)),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     hintText: 'Masukkan Kode Perangkat',
                      //     hintStyle: TextStyle(fontSize: 14),
                      //   ),
                      //   onChanged: (value) {
                      //     _numberOfParticipants = int.tryParse(value);
                      //   },
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Kode perangkat tidak boleh kosong';
                      //     }
                      //     if (int.tryParse(value) == null) {
                      //       return 'Kode perangkat harus berupa angka';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(height: 20),
                      // Text('Bentuk Kerusakan atau Kendala', style: TextStyle(fontWeight: FontWeight.bold)),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Masukkan bentuk kerusakan atau kendala',
                      //     hintStyle: TextStyle(fontSize: 14),
                      //   ),
                      //   onChanged: (value) {
                      //     _purpose = value;
                      //   },
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Bentuk kerusakan atau kendala tidak boleh kosong';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      const SizedBox(height: 20),
                      const Text('Deskripsi Kerusakan atau Kendala', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Masukkan deskripsi dengan lengkap',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onChanged: (value) {
                          _purpose = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
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
                              if (_formKey.currentState?.validate() ?? false) {
                                // Process the form submission
                                _submitForm().then((response) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(response.values.first),
                                    ),
                                  );

                                  setState(() {
                                    _selectedRoom = null;
                                    _selectedIssueType = null;
                                    _selectedBentukKendala = null;
                                    _selectedDate = null;
                                    _selectedTime = null;
                                    _numberOfParticipants = null;
                                    _purpose = null;
                                  });
                                });
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