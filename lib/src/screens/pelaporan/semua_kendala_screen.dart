import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/report_card.dart';
// import 'package:class_leap/src/utils/data/dummy_report.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

class SemuakendalaPage extends StatefulWidget {
  final String room;

  const SemuakendalaPage({super.key, required this.room});

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

    factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      studentName: json['nama_pelapor'],
      studentNim: json['nim_nrp'],
      inputDate: json['tanggal'],
      ruangan: json['nama_ruangan'],
      jenis: json['jenis_kendala'],
      bentuk: json['bentuk_kendala'],
      deskripsi: json['deskripsi_kendala'],
      status: json['status'],
    );
  }
}

class _SemuakendalaPageState extends State<SemuakendalaPage> {
  late Future<List<Report>> _kendalaFuture;
  String _selectedStatus = 'selesai';
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _kendalaFuture = fetchPeminjaman();
  }

  Future<List<Report>> fetchPeminjaman() async {
    List<Map<String, dynamic>> kendala;
    kendala = await api_data.getKendala(widget.room);
    print(kendala);
    return kendala.map((data) => Report.fromJson(data)).toList();
  }

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
          title: const Text(
            'Semua Daftar Pelaporan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFFF5833),
          iconTheme: const IconThemeData(
            color: Colors.white, // Set all icons to white
          ),
          bottom: const TabBar(
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
                    child: const Text('Pilih Tanggal'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
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
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder<List<Report>>(
                      future: _kendalaFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Tidak data laporan kendala'));
                        } else {
                          List<Report> bookings = snapshot.data!
                              .where((booking) => booking.status == 'menunggu')
                              .toList();
                          return ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              Report booking = bookings[index];
                              return ReportCard(
                                studentName: booking.studentName,
                                studentNim: booking.studentNim,
                                inputDate: booking.inputDate,
                                ruangan: booking.ruangan,
                                jenis: booking.jenis,
                                bentuk: booking.bentuk,
                                deskripsi: booking.deskripsi,
                                status: booking.status,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  // Tab for "Riwayat"
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: _selectedStatus,
                          items: const [
                            DropdownMenuItem(
                              value: 'menunggu',
                              child: Text('Menunggu'),
                            ),
                            DropdownMenuItem(
                              value: 'dalam proses',
                              child: Text('Dalam Proses'),
                            ),
                            DropdownMenuItem(
                              value: 'selesai',
                              child: Text('Selesai'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: FutureBuilder<List<Report>>(
                            future: _kendalaFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(child: Text('Tidak data laporan kendala'));
                              } else {
                                List<Report> bookings = snapshot.data!
                                    .where((booking) => booking.status == _selectedStatus)
                                    .toList();
                                return ListView.builder(
                                  itemCount: bookings.length,
                                  itemBuilder: (context, index) {
                                    Report booking = bookings[index];
                                    return ReportCard(
                                      studentName: booking.studentName,
                                      studentNim: booking.studentNim,
                                      inputDate: booking.inputDate,
                                      ruangan: booking.ruangan,
                                      jenis: booking.jenis,
                                      bentuk: booking.bentuk,
                                      deskripsi: booking.deskripsi,
                                      status: booking.status,
                                    );
                                  },
                                );
                              }
                            },
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
      return const Center(child: Text('Tidak ada data'));
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