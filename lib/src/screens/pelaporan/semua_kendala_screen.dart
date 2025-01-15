import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/report_card.dart';
import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:intl/intl.dart';

class SemuakendalaPage extends StatefulWidget {
  final String room;

  const SemuakendalaPage({super.key, required this.room});

  @override
  _SemuakendalaPageState createState() => _SemuakendalaPageState();
}

class Report {
  final String id;
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String bentuk;
  final String deskripsi;
  final int idStatus;
  final String tanggalPenyelesaian;
  final String keteranganPenyelesaian;
  final bool isActive;

  Report({
    required this.id,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
    required this.idStatus,
    required this.tanggalPenyelesaian,
    required this.keteranganPenyelesaian,
    required this.isActive,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'].toString(),
      studentName: json['nama_pelapor'],
      studentNim: json['nim_nrp'],
      inputDate: json['tanggal'],
      ruangan: json['nama_ruangan'],
      jenis: json['jenis_kendala'],
      bentuk: json['bentuk_kendala'],
      deskripsi: json['deskripsi_kendala'],
      idStatus: json['id_status'],
      tanggalPenyelesaian: json['tanggal_penyelesaian'] ?? '',
      keteranganPenyelesaian: json['keterangan_penyelesaian'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}

class _SemuakendalaPageState extends State<SemuakendalaPage> with SingleTickerProviderStateMixin {
  late Future<List<Report>> _kendalaActiveFuture;
  late Future<List<Report>> _kendalaHistoryFuture;
  late Future<List<Map<String, dynamic>>> _statusFuture;
  String? _selectedStatus;
  DateTimeRange? _selectedDateRange;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && _tabController.index == _tabController.animation!.value) {
        setState(() {
          _selectedStatus = null;
          _selectedDateRange = null;
        });
        refreshKendala();
      }
    });
    _kendalaActiveFuture = fetchKendala(true);
    _kendalaHistoryFuture = fetchKendala(false);
    _statusFuture = getStatus(isActive: true, fungsi: 'kendala');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStatusDropdown(bool isActive){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: getStatus(isActive: isActive, fungsi: 'kendala'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var statuses = snapshot.data!.where((status) =>
            status['fungsi'] == 'kendala' &&
                status['is_active'] == isActive
            ).toList();

            return DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Filter Status',
                border: OutlineInputBorder(),
              ),
              items: statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status['id_status'].toString(),
                  child: Text(status['status']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
                refreshKendala();
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  void refreshKendala() {
    setState(() {
      _kendalaActiveFuture = fetchKendala(true);
      _kendalaHistoryFuture = fetchKendala(false);
    });
  }

  Future<List<Report>> fetchKendala(bool isActive) async {
    List<Map<String, dynamic>> kendala = await getKendala(widget.room, isActive: isActive);
    var reports = kendala.map((data) => Report.fromJson(data)).where((reporting) {
      if (isActive) {
        return reporting.idStatus == 1 || reporting.idStatus == 2;
      } else {
        return reporting.idStatus == 3;
      }
    }).toList();

    // Apply status filter
    if (_selectedStatus != null) {
      reports = reports.where((report) => report.idStatus.toString() == _selectedStatus).toList();
    }

    // Apply date range filter
    if (_selectedDateRange != null) {
      reports = reports.where((report) {
        final reportDate = DateFormat('dd/MM/yyyy').parse(report.inputDate);
        return reportDate.isAfter(_selectedDateRange!.start) && reportDate.isBefore(_selectedDateRange!.end);
      }).toList();
    }

    return reports;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange,
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


  List<Report> _filterReports(List<Report> reports, bool isActive) {
    var filtered = reports;

    if (_selectedStatus != null) {
      filtered = filtered.where((report) => report.idStatus.toString() == _selectedStatus).toList();
    }
    if (_selectedDateRange != null) {
      filtered = filtered.where((reporting) {
        final reportingDate = DateFormat('dd/MM/yyyy').parse(reporting.inputDate);
        return reportingDate.isAfter(_selectedDateRange!.start) &&
            reportingDate.isBefore(_selectedDateRange!.end);
      }).toList();
    }
    return filtered;
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
          bottom: TabBar(
            controller: _tabController,
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
                    child: const Text('Pilih Rentang Waktu'),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 30, // Adjust the width
                    height: 30, // Adjust the height
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Background color
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearDateRange,
                        iconSize: 20.0, // Adjust the size
                        color: Colors.red, // Adjust the color
                        padding: EdgeInsets.zero, // Remove padding
                      ),
                    ),
                  ),
                  if (_selectedDateRange != null)
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Sedang Berjalan tab
                  Column(
                    children: [
                      _buildStatusDropdown(true),
                      Expanded(
                        child: FutureBuilder<List<Report>>(
                          future: _kendalaActiveFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              var filteredReports = _filterReports(snapshot.data!, true);
                              if (filteredReports.isEmpty) {
                                return const Center(child: Text('Tidak ada data'));
                              }
                              return ListView.builder(
                                itemCount: filteredReports.length,
                                itemBuilder: (context, index) {
                                  final report = filteredReports[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child:
                                      ReportCard(
                                        id: report.id,
                                        studentName: report.studentName,
                                        studentNim: report.studentNim,
                                        inputDate: report.inputDate,
                                        ruangan: report.ruangan,
                                        jenis: report.jenis,
                                        bentuk: report.bentuk,
                                        deskripsi: report.deskripsi,
                                        idStatus: report.idStatus.toString(),
                                        keteranganPenyelesaian: report.keteranganPenyelesaian,
                                      ),
                                  );
                                },
                              );
                            }
                            return const Center(child: Text('Tidak ada data'));
                          },
                        ),
                      ),
                    ],
                  ),
                  // Riwayat tab
                  Column(
                    children: [
                      _buildStatusDropdown(false),
                      Expanded(
                        child: FutureBuilder<List<Report>>(
                          future: _kendalaHistoryFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              var filteredReports = _filterReports(snapshot.data!, false);
                              if (filteredReports.isEmpty) {
                                return const Center(child: Text('Tidak ada data'));
                              }
                              return ListView.builder(
                                itemCount: filteredReports.length,
                                itemBuilder: (context, index) {
                                  final report = filteredReports[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child:
                                      ReportCard(
                                        id: report.id,
                                        studentName: report.studentName,
                                        studentNim: report.studentNim,
                                        inputDate: report.inputDate,
                                        ruangan: report.ruangan,
                                        jenis: report.jenis,
                                        bentuk: report.bentuk,
                                        deskripsi: report.deskripsi,
                                        idStatus: report.idStatus.toString(),
                                        keteranganPenyelesaian: report.keteranganPenyelesaian,
                                      ),
                                  );
                                },
                              );
                            }
                            return const Center(child: Text('Tidak ada data'));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}