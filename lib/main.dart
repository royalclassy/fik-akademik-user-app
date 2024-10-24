import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/features/authentication/screens/profile_page.dart';
import 'package:class_leap/src/features/authentication/screens/welcome_screen.dart';
import 'package:class_leap/src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB_n1_uHwaWw8Qk5KLB_cppwjOWAgMJgRE",
      authDomain: "claeapthesis.firebaseapp.com",
      projectId: "claeapthesis",
      storageBucket: "claeapthesis.appspot.com",
      messagingSenderId: "478482507446",
      appId: "1:478482507446:web:cc76596a3ba5c5d05aa817",
      measurementId: "G-XXXXXXXXXX", // If available
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassLeap',
      theme: lightMode,
      home: const WelcomeScreen(),
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}