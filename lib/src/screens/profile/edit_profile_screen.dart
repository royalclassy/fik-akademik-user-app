import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class EditProfilePage extends StatefulWidget {
  final String name;
  final String nim;
  final String no_tlp;
  final String email;
  final String idProdi;
  final String profile;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.nim,
    required this.no_tlp,
    required this.email,
    required this.idProdi,
    required this.profile,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _nim;
  late String _no_tlp;
  late String _email;
  late String _idProdi;
  late String _profile;
  List<Map<String, dynamic>> _prodiList = [];
  File? _image;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _nim = widget.nim;
    _no_tlp = widget.no_tlp;
    _email = widget.email;
    _idProdi = widget.idProdi;
    _profile = widget.profile;
    _fetchProdiData();
  }

  Future<void> _fetchProdiData() async {
    try {
      List<Map<String, dynamic>> prodiData = await api_data.getProdi();
      setState(() {
        _prodiList = prodiData;
        if (!_prodiList.any((prodi) => prodi['id_prodi'].toString() == _idProdi)) {
          _idProdi = _prodiList[0]['id_prodi'].toString();
        }
      });
    } catch (e) {
      print('Failed to fetch prodi data: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_image != null) {
          await api_data.updateProfile(_name, _nim, _no_tlp, _email, _idProdi, _image!);
        } else {
          await api_data.updateProfile(_name, _nim, _no_tlp, _email, _idProdi, File(''));
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
    print(_image);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFFFFFFFF),
        )),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : NetworkImage(_profile) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _nim,
                decoration: InputDecoration(labelText: 'NIM'),
                onSaved: (value) => _nim = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your NIM';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _no_tlp,
                decoration: InputDecoration(labelText: 'No. Telepon'),
                onSaved: (value) => _no_tlp = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Nomor Telepon';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _idProdi,
                decoration: InputDecoration(labelText: 'Prodi'),
                items: _prodiList.map((prodi) {
                  return DropdownMenuItem<String>(
                    value: prodi['id_prodi'].toString(),
                    child: Text(prodi['nama_prodi']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _idProdi = value!;
                  });
                },
                onSaved: (value) => _idProdi = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your prodi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}