import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:class_leap/src/screens/pelaporan/semua_kendala_screen.dart';

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
  bool _isLoading = false; // Add this variable to track loading state

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
    return response;
  }

void _showResultDialog(bool success, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(success ? 'Success' : 'Error'),
        content: Text(success ? 'Pelaporanmu sedang diproses!' : message),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SemuakendalaPage(room: widget.room)),
                );
              },
              child: const Text('Lihat Kendalamu'),
            ),
        ],
      );
    },
  );
}

  void _handleSubmit() async {
  if (_formKey.currentState?.validate() ?? false) {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final response = await _submitForm();
      print('Response: $response'); // Debug print to check the response structure
      bool success = response.containsKey(200);
      String message = response.values.first;
      _showResultDialog(true, message);
    } catch (error) {
      _showResultDialog(false, 'Failed to submit the form. Please try again.');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }
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
      body: Stack(
        children: [
          LayoutBuilder(
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
                                onPressed: _isLoading ? null : _handleSubmit,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                  backgroundColor: const Color(0xFF2F4858), // Set the button color here
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: _isLoading
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : const Text(
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
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}