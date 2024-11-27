import 'package:class_leap/src/screens/welcome/welcome_screen.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool isLoading = true; // Add this variable to track loading state

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

      // Handle the nested prodi field
      final prodiData = userData['prodi'];
      if (prodiData != null) {
        // Extract the necessary fields from the nested prodi object
        prodi = prodiData['nama_prodi'];
        // You can add more fields as needed
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profil',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader if loading
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                // backgroundImage: AssetImage('images/bg1.png'),
                backgroundImage: Image.network(profile ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png').image,
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Nama', value: name),
              const SizedBox(height: 20),
              _buildProfileField(label: 'NIM', value: nim),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Prodi', value: prodi),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Email', value: email),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
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