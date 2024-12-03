import 'dart:io';

import 'package:class_leap/src/screens/welcome/welcome_screen.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String nim = '';
  String email = '';
  String profile = '';
  String prodi = '';
  bool isLoading = true;
  File? image;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await api_data.fetchUserData();

    if (userData != null && mounted) {
      setState(() {
        name = userData['nama']!;
        nim = userData['nim_nrp']!;
        email = userData['email']!;
        profile = userData['profil'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

        final prodiData = userData['prodi'];
        if (prodiData != null) {
          prodi = prodiData['nama_prodi'];
        }

        isLoading = false;
      });
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditProfile() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditProfilePage(
        name: name,
        nim: nim,
        email: email,
        idProdi: prodi,
        profile: profile,
      ),
    ),
  ).then((_) {
    _fetchUserData();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profil', style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profile),
              ),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Nama', value: name),
              const SizedBox(height: 10),
              _buildProfileField(label: 'NIM', value: nim),
              const SizedBox(height: 10),
              _buildProfileField(label: 'Email', value: email),
              const SizedBox(height: 10),
              _buildProfileField(label: 'Prodi', value: prodi),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToEditProfile,
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showLogoutConfirmationDialog,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}