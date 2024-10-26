// // import 'package:flutter/material.dart';
// // import 'package:icons_plus/icons_plus.dart';
// //
// // class ProfilePage extends StatelessWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// // //         leading: IconButton(
// // //           onPressed: () {},
// // //           icon: const Icon(LineAwesome.angle_left_solid),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             onPressed: () {},
// // //             icon: const Icon(LineAwesome.sun),
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(20.0),
// // //           child: Column(
// // //             children: [
// // //               const CircleAvatar(
// // //                 radius: 50,
// // //                 backgroundImage: AssetImage('assets/images/sylus.jpg'),
// // //               ),
// // //               const SizedBox(height: 20),
// // //               const Text(
// // //                 'Sylus Esterlita',
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 20),
// // //               _buildProfileField(label: 'Nama', value: 'Esterlita'),
// // //               const SizedBox(height: 20),
// // //               _buildProfileField(label: 'NIM', value: '2110511050'),
// // //               const SizedBox(height: 20),
// // //               _buildProfileField(label: 'Email', value: 'example@example.com'),
// // //               const SizedBox(height: 20),
// // //               _buildProfileField(label: 'Phone Number', value: '123-456-7890'),
// // //               const SizedBox(height: 20),
// // //               _buildProfileField(label: 'Prodi', value: 'Computer Science'),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildProfileField({required String label, required String value}) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: [
// // //         Text(
// // //           label,
// // //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //         ),
// // //         Text(
// // //           value,
// // //           style: const TextStyle(fontSize: 16),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:icons_plus/icons_plus.dart';
// //
// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }
// //
// // class _ProfilePageState extends State<ProfilePage> {
// //   User? user;
// //   String name = '';
// //   String nim = '';
// //   String email = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserData();
// //   }
// //
// //   void _fetchUserData() async {
// //     user = FirebaseAuth.instance.currentUser;
// //     if (user != null) {
// //       DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
// //       setState(() {
// //         name = userData['displayName'] ?? 'No Name';
// //         email = userData['email'] ?? 'No Email';
// //         nim = userData['nim'] ?? 'No NIM';
// //       });
// //     }
// //   }
// //
// //
// //   void _changePassword(String newPassword) async {
// //     try {
// //       await user!.updatePassword(newPassword);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Password updated successfully')),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e')),
// //       );
// //     }
// //   }
// //
// //   void _showChangePasswordDialog() {
// //     final TextEditingController _passwordController = TextEditingController();
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Change Password'),
// //           content: TextField(
// //             controller: _passwordController,
// //             obscureText: true,
// //             decoration: const InputDecoration(labelText: 'New Password'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 _changePassword(_passwordController.text);
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text('Change'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// //         leading: IconButton(
// //           onPressed: () {},
// //           icon: const Icon(LineAwesome.angle_left_solid),
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () {},
// //             icon: const Icon(LineAwesome.sun),
// //           ),
// //           IconButton(
// //             onPressed: () async {
// //               await FirebaseAuth.instance.signOut();
// //               Navigator.pushReplacementNamed(context, '/welcome');
// //             },
// //             icon: const Icon(Icons.logout),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             children: [
// //               const CircleAvatar(
// //                 radius: 50,
// //                 backgroundImage: AssetImage('assets/images/sylus.jpg'),
// //               ),
// //               const SizedBox(height: 20),
// //               Text(
// //                 name,
// //                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Nama', value: name),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'NIM', value: nim),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Email', value: email),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Phone Number', value: '123-456-7890'),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Prodi', value: 'Computer Science'),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProfileField({required String label, required String value}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //         ),
// //         Text(
// //           value,
// //           style: const TextStyle(fontSize: 16),
// //         ),
// //       ],
// //     );
// //   }
// // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:icons_plus/icons_plus.dart';
// // import 'reset_password_page.dart';
// //
// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }
// //
// // class _ProfilePageState extends State<ProfilePage> {
// //   User? user;
// //   String name = '';
// //   String nim = '';
// //   String email = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserData();
// //   }
// //
// //   void _fetchUserData() async {
// //     user = FirebaseAuth.instance.currentUser;
// //     if (user != null) {
// //       DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
// //       setState(() {
// //         name = userData['displayName'] ?? 'No Name';
// //         email = userData['email'] ?? 'No Email';
// //         nim = userData['nim'] ?? 'No NIM';
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// //         leading: IconButton(
// //           onPressed: () {},
// //           icon: const Icon(LineAwesome.angle_left_solid),
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () {},
// //             icon: const Icon(LineAwesome.sun),
// //           ),
// //           IconButton(
// //             onPressed: () async {
// //               await FirebaseAuth.instance.signOut();
// //               Navigator.pushReplacementNamed(context, '/welcome');
// //             },
// //             icon: const Icon(Icons.logout),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             children: [
// //               const CircleAvatar(
// //                 radius: 50,
// //                 backgroundImage: AssetImage('assets/images/sylus.jpg'),
// //               ),
// //               const SizedBox(height: 20),
// //               Text(
// //                 name,
// //                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Nama', value: name),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'NIM', value: nim),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Email', value: email),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Phone Number', value: '123-456-7890'),
// //               const SizedBox(height: 20),
// //               _buildProfileField(label: 'Prodi', value: 'Computer Science'),
// //               const SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
// //                   );
// //                 },
// //                 child: const Text('Reset Password'),
// //                 style: ButtonStyle(
// //                   backgroundColor: MaterialStateProperty.all(Color(0xFF3D5A80)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProfileField({required String label, required String value}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //         ),
// //         Text(
// //           value,
// //           style: const TextStyle(fontSize: 16),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   String name = '';
//   String nim = '';
//   String email = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }
//
//   Future<void> _fetchUserData() async {
//     final userId = await _readUserId();
//     if (userId != null) {
//       try {
//         final response = await http.get(
//           Uri.parse('http://192.168.1.64:8000/api/user/$userId'),
//         );
//
//         if (response.statusCode == 200) {
//           final userData = jsonDecode(response.body);
//           setState(() {
//             name = userData['name'];
//             nim = userData['nim'];
//             email = userData['email'];
//           });
//         } else {
//           print('Failed to load user data');
//         }
//       } catch (e) {
//         print('Error: $e');
//       }
//     }
//   }
//
//   Future<String?> _readUserId() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final path = directory.path;
//       final file = File('$path/user_id.txt');
//       final userId = await file.readAsString();
//       return userId;
//     } catch (e) {
//       print('Error reading user_id: $e');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
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
//               Text(
//                 name,
//                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Nama', value: name),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'NIM', value: nim),
//               const SizedBox(height: 20),
//               _buildProfileField(label: 'Email', value: email),
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

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    if (userId != null) {
      try {
        final response = await http.get(
          Uri.parse('http://192.168.1.64:8000/api/user/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);
          setState(() {
            name = userData['nama'];
            nim = userData['id_user'];
            email = userData['email'];
          });
        } else {
          print('Failed to load user data');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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