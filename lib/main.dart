import 'package:class_leap/src/screens/welcome/signup_screen.dart';
import 'package:class_leap/src/screens/welcome/signin_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/screens/profile/profile_page.dart';
import 'package:class_leap/src/screens/welcome/welcome_screen.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_screen.dart';
import 'package:class_leap/src/screens/peminjaman/peminjaman_screen.dart';
import 'package:class_leap/src/screens/pelaporan/pelaporan_screen.dart';
import 'package:class_leap/src/screens/kalender/kalender_akademik_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:class_leap/src/utils/data/firebase_options.dart';

Future<bool> _onWillPop() async {
  // Exit the app when back button is pressed
  SystemNavigator.pop();
  return false;
}

Future<void> saveUserToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token);
}

Future<String?> getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}

Future<void> removeUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_token');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'admin-fik-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('firebase initialized');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('firebase messaging initialized');
  String? userToken = await getUserToken();
  runApp(MyApp(isLoggedIn: userToken != null));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Menyimpan indeks halaman yang dipilih

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      print('FCM Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Show a dialog or a snackbar
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(message.notification!.title ?? 'Notification'),
            content: Text(message.notification!.body ?? 'No body'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle the notification tap
      setState(() {
        _selectedIndex = 1; // Navigate to the Peminjaman page
      });
    });
  }

  // Daftar halaman yang ditampilkan berdasarkan indeks
  final List<Widget> _pages = [
    const JadwalPage(),
    const PeminjamanPage(),
    const AcademicCalendarPage(),
    const PelaporanPage(),
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
        '/home': (context) => WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
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
        ),
      },
    );
  }
}