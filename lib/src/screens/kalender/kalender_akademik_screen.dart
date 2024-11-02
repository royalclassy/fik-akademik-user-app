import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AcademicCalendarPage extends StatefulWidget {
  @override
  _AcademicCalendarPageState createState() => _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends State<AcademicCalendarPage> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/academic_calendar.pdf');

    // Assuming you have the PDF file in your assets
    final data = await DefaultAssetBundle.of(context).load('assets/academic_calendar.pdf');
    await file.writeAsBytes(data.buffer.asUint8List());

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Calendar'),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath!,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}