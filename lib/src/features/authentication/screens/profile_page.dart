// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(LineAwesome.angle_left_solid),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(LineAwesome.sun),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage('assets/images/sylus.jpg'),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Sylus Esterlita',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Nama', value: 'Esterlita'),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'NIM', value: '2110511050'),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Email', value: 'example@example.com'),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Phone Number', value: '123-456-7890'),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Prodi', value: 'Computer Science'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileField({required String label, required String value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           value,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String name = '';
  String nim = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        name = userData['displayName'] ?? 'No Name';
        email = userData['email'] ?? 'No Email';
        nim = userData['nim'] ?? 'No NIM';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesome.angle_left_solid),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesome.sun),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/sign-out');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/sylus.jpg'),
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
              _buildProfileField(label: 'Email', value: email),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Phone Number', value: '123-456-7890'),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Prodi', value: 'Computer Science'),
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