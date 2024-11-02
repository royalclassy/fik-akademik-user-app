import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/report_card.dart';
import 'package:class_leap/src/utils/data/dummy_report.dart'; // Import dummy data

class KendaladikerjakanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Laporan Kendala Dikejakan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ReportCard(
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Pengerjaan',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Pengerjaan',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Pengerjaan',
            ),
          ],
        ),
      ),
    );
  }
}