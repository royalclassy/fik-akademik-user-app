import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/report_card.dart';
import 'package:class_leap/src/utils/data/dummy_report.dart';
import 'package:intl/intl.dart';

class SemuakendalaPage extends StatefulWidget {
  @override
  _SemuakendalaPageState createState() => _SemuakendalaPageState();
}

class Report {
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String bentuk;
  final String deskripsi;
  final String status;

  Report({
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
    required this.status,
  });
}
class _SemuakendalaPageState extends State<SemuakendalaPage> {
  String _selectedStatus = 'Selesai';
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _selectedDateRange = null;
    });
  }

  List<Report> _filterReports(List<Report> reports) {
    if (_selectedDateRange == null) return reports;
    return reports.where((report) {
      final reportDate = DateFormat('dd/MM/yyyy').parse(report.inputDate);
      return reportDate.isAfter(_selectedDateRange!.start) &&
          reportDate.isBefore(_selectedDateRange!.end);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Semua Daftar Pelaporan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFFFF5833),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'Sedang Berjalan'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDateRange(context),
                    child: Text('Pilih Tanggal'),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearDateRange,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab for "Sedang Berjalan"
                  Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: _buildReportList(
                      _filterReports(DummyData.reports)
                          .where((report) => report.status == 'Diproses')
                          .toList(),
                    ),
                  ),
                  // Tab for "Riwayat"
                  Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: _selectedStatus,
                          items: ['Selesai', 'Dibatalkan']
                              .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: _buildReportList(
                            _filterReports(DummyData.reports)
                                .where((report) => report.status == _selectedStatus)
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<Report> reports) {
    if (reports.isEmpty) {
      return Center(child: Text('Tidak ada data'));
    }
    return ListView(
      children: reports.map((report) => ReportCard(
        studentName: report.studentName,
        studentNim: report.studentNim,
        inputDate: report.inputDate,
        ruangan: report.ruangan,
        jenis: report.jenis,
        bentuk: report.bentuk,
        deskripsi: report.deskripsi,
        status: report.status,
      )).toList(),
    );
  }
}