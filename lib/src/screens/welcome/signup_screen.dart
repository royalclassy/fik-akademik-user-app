import 'package:class_leap/src/screens/jadwal/jadwal_screen.dart';
import 'package:class_leap/src/screens/profile/profile_page.dart';
import 'package:class_leap/src/screens/welcome/signin_screen.dart';
import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:class_leap/src/utils/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:class_leap/src/user/firebase_auth_services.dart';
import 'package:class_leap/src/utils/theme/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();



  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nimController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_formSignUpKey.currentState!.validate()) {
      // Debug prints to check the values
      // print('NIM: ${_nimController.text}');
      // print('Email: ${_emailController.text}');
      // print('Password: ${_passwordController.text}');
      // print('Display Name: ${_displayNameController.text}');
      // print('Phone: ${_phoneController.text}');
      // print('Role: $_selectedRoleInt');
      // print('Program: $_selectedProgramInt');

      String nim = await signUp(
        _displayNameController.text,
        _nimController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text,
        _selectedRoleInt!,
        _selectedProgramInt!,
      );

      // print('NIM: $nim');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login success')),
      );

      Navigator.pushReplacementNamed(context, '/home');
        }
  }

  final _formSignUpKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  // List of program options
  final List<String> _programs = [
    'S1 Informatika',
    'S1 Sistem Informasi',
    'D3 Sistem Informasi',
    'S1 Data Sains',
    'Lainnya'
  ];

  final List<String> _roles = [
    'Dosen',
    'Mahasiswa',
    'Tenaga Didik'
  ];

  // List of integers corresponding to the program options
  final List<int> _programsInt = [0, 1, 2, 3, 4];
  final List<int> _rolesInt = [6, 7, 8];

  // Variable to hold the selected program
  String? _selectedProgram;
  int? _selectedProgramInt;
  String? _selectedRole;
  int? _selectedRoleInt;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignUpKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mulai dengan mendaftar',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _nimController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan NRP/NIM anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('NRP/NIM'),
                          hintText: 'Masukkan NRP/NIM anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan email anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Masukkan email anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _displayNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan nama anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Nama'),
                          hintText: 'Masukkan nama anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan nomor telepon anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Nomor Telepon'),
                          hintText: 'Masukkan nomor telepon anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        hint: const Text('Pilih Peran'),
                        items: _roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRole = newValue;
                            _selectedRoleInt = _rolesInt[_roles.indexOf(newValue!)];
                          });
                          print('Selected role: $_selectedRoleInt');
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih Peran anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedProgram,
                        hint: const Text('Pilih Program Studi'),
                        items: _programs.map((String program) {
                          return DropdownMenuItem<String>(
                            value: program,
                            child: Text(program),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProgram = newValue;
                            _selectedProgramInt = _programs.indexOf(newValue!);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih Program Studi anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Buat kata sandi anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Kata Sandi'),
                          hintText: 'Buat kata sandi anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: agreePersonalData,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      agreePersonalData = value!;
                                    });
                                  },
                                  activeColor: lightColorScheme.primary,
                                ),
                                const Flexible(
                                  child: Text(
                                    'Saya setuju menggunakan data pribadi saya',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                lightColorScheme.primary),
                          ),
                          onPressed: () {
                            _handleSignUp();
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              color: lightColorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Text(
                              'Sudah punya akun?',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (e) => const SignInScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0), // Add padding to the right
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  color: lightColorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String displayName = _displayNameController.text;
    String nim = _nimController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Store NIM and selected program in Firestore or Realtime Database
          await FirebaseFirestore.instance.collection('users')
              .doc(user.uid)
              .set({
            'displayName': displayName,
            'nim': nim,
            'email': email,
            'program': _selectedProgramInt, // Store the selected program as an integer
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign up success'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const JadwalPage(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign up failed'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}, ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }
}