// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// class AcademicCalendarPage extends StatefulWidget {
//   const AcademicCalendarPage({super.key});
//
//   @override
//   _AcademicCalendarPageState createState() => _AcademicCalendarPageState();
// }
//
// class _AcademicCalendarPageState extends State<AcademicCalendarPage> with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   String? localPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _loadPdf('Universitas');
//     _tabController!.addListener(() {
//       if (_tabController!.indexIsChanging) {
//         _loadPdf(_tabController!.index == 0 ? 'Universitas' : 'Fakultas');
//       }
//     });
//   }
//
//   Future<void> _loadPdf(String category) async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/academic_calendar.pdf');
//
//     // Load the appropriate PDF based on the selected category
//     final pdfAsset = category == 'Universitas'
//         ? 'assets/files/kalender_universitas.pdf'
//         : 'assets/files/kalender_fik.pdf';
//
//     final data = await DefaultAssetBundle.of(context).load(pdfAsset);
//     await file.writeAsBytes(data.buffer.asUint8List());
//
//     setState(() {
//       localPath = file.path;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'Kalender Akademik',
//           style: TextStyle(
//             color: Color(0xFFFFFFFF),
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color(0xFFFF5833),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           labelStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontFamily: 'Poppins',
//           ),
//           tabs: const [
//             Tab(text: 'Universitas'),
//             Tab(text: 'Fakultas'),
//           ],
//         ),
//       ),
//       body: Expanded(
//         child: TabBarView(
//           controller: _tabController,
//           children: [
//             localPath != null
//                 ? PDFView(filePath: localPath!)
//                 : const Center(child: CircularProgressIndicator()),
//             localPath != null
//                 ? PDFView(filePath: localPath!)
//                 : const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AcademicCalendarPage extends StatefulWidget {
  const AcademicCalendarPage({super.key});

  @override
  _AcademicCalendarPageState createState() => _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends State<AcademicCalendarPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? localPath;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPdf('Universitas');
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        _loadPdf(_tabController!.index == 0 ? 'Universitas' : 'Fakultas');
      }
    });
  }

  Future<void> _loadPdf(String category) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/academic_calendar.pdf');

    // Load the appropriate PDF based on the selected category
    final pdfAsset = category == 'Universitas'
        ? 'assets/files/kalender_universitas.pdf'
        : 'assets/files/kalender_fik.pdf';

    final data = await DefaultAssetBundle.of(context).load(pdfAsset);
    await file.writeAsBytes(data.buffer.asUint8List());

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Kalender Akademik',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
          ),
          tabs: const [
            Tab(text: 'Universitas'),
            Tab(text: 'Fakultas'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            localPath != null
                ? PDFView(filePath: localPath!)
                : const Center(child: CircularProgressIndicator()),
            localPath != null
                ? PDFView(filePath: localPath!)
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}