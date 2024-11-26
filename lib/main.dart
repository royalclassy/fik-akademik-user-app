import 'package:class_leap/src/screens/jadwal/jadwal_lab_screen.dart';
import 'package:class_leap/src/screens/welcome/sign_up_screen_api.dart';
import 'package:class_leap/src/screens/welcome/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/screens/profile/profile_page.dart';
import 'package:class_leap/src/screens/welcome/welcome_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_screen.dart';
import 'package:class_leap/src/screens/peminjaman/peminjaman_screen.dart';
import 'package:class_leap/src/screens/pelaporan/pelaporan_screen.dart';
import 'package:class_leap/src/screens/kalender/kalender_akademik_screen.dart';
import 'package:class_leap/src/utils/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Menyimpan indeks halaman yang dipilih

  // Daftar halaman yang ditampilkan berdasarkan indeks
  final List<Widget> _pages = [
    const JadwalPage(),
    PeminjamanPage(),
    AcademicCalendarPage(),
    PelaporanPage(),
    const ProfilePage(),
  ];

  // Fungsi untuk mengganti halaman saat tombol BottomNavigationBar diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClassLeap',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFF5833), // Primary color
          secondary: const Color(0xFFFFBE33), // Secondary color
          tertiary: const Color(0xFFFF3374), // Tertiary color
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(), // Ensure this route is defined
        '/home': (context) => Scaffold(
          body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan indeks
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFFF5833), // Color of the top border
                  width: 2.0, // Width of the top border
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFFFFFFF),
              selectedItemColor: const Color(0xFFFF5833), // Warna icon dan text yang dipilih
              unselectedItemColor: const Color(0x66FF5833), // Warna icon dan text yang tidak dipilih
              currentIndex: _selectedIndex, // Indeks yang aktif
              onTap: _onItemTapped, // Mengubah indeks saat diklik
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmarks_outlined),
                  label: 'Pinjam',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_rounded),
                    label: 'Kalender',
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.warning_amber_rounded),
                  label: 'Lapor',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      },
    );
  }
}