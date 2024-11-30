import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class FormPelaporan extends StatefulWidget {
  final String room;

  const FormPelaporan({super.key, required this.room});

  @override
  _FormPelaporanState createState() => _FormPelaporanState();
}

class _FormPelaporanState extends State<FormPelaporan> {
  List<Map<String, String>> ruanganList = [];
  List<Map<String, String>> listAset = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedRoom;
  String? _selectedAset;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _numberOfParticipants;
  String? _purpose;

  @override
  void initState() {
    super.initState();
    getRuangan();
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

    Future<void> getBentukKendala() async {
    var data = await api_data.getBentukKendala();
    setState(() {
      listAset = List<Map<String, String>>.from(data.map((item) => {
        'id_aset': item['id_aset'].toString(),
        'nama_aset': item['nama_aset'].toString(),
      }));
    });
  }

    Future<Map<int, String>> _submitForm() async {
    final Map<int, String> response = await api_data.createKendala(
      _selectedRoom!,
      _selectedAset!,
      _purpose!,
    );
    print(response);
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
                      const Text('Bentuk Kendala', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Pilih bentuk kendala (aset)',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        value: _selectedAset,
                        items: listAset.map((item) {
                          return DropdownMenuItem(
                            value: item['id_aset'],
                            child: Text(item['nama_aset']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedAset = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bentuk kendala tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
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
                                    _selectedAset = null;
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
                            child: const Text(
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