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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'class_leap',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  // Request notification permissions
  await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false
  );
  print('Notification permissions granted');

  // Create notification channel
  if (Platform.isAndroid) {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        print('Notification channel created');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('Background message handler registered');
  String? userToken = await getUserToken();
  runApp(MyApp(isLoggedIn: userToken != null));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'class_leap',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase app initialized');
  }

  print('Background service initialized');
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
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
    _initNotifications();
    _setupFCM();
  }

  // Daftar halaman yang ditampilkan berdasarkan indeks
  final List<Widget> _pages = [
    const JadwalPage(),
    const PeminjamanPage(),
    const AcademicCalendarPage(),
    const PelaporanPage(),
    const ProfilePage(),
  ];

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('Local notifications initialized');
  }

  void _setupFCM() {
    print('Setting up FCM');
    print( "default options"+ DefaultFirebaseOptions.currentPlatform.toString());
    try {
      FirebaseMessaging.instance.getToken().then((token) async {
        if (token != null) {
          print('FCM Token: $token');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('fcm_token', token);
        } else {
          print('Failed to get FCM token: Token is null');
        }
      }).catchError((error) {
        print('Error getting FCM token: $error');
      });
    }
    catch (e) {
      print('Unexpected error in FCM setup: $e');
    }
    print('Setting up FCM');
    try {
      FirebaseMessaging.instance.getToken().then((token) async {
        print('FCM Token: $token');
        print('Saving FCM Token');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token!);
      });
    }
    catch (e) {
      print('Error getting FCM token: $e');
    }

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      print('FCM Token Refreshed: $token');
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification}');

      if (message.notification != null) {
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    // Handle notification open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      setState(() {
        _selectedIndex = 1; // Navigate to Peminjaman page
      });
    });
  }

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