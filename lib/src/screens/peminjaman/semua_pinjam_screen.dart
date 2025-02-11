import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/booking_card.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

import '../../utils/data/api_data.dart';

class SemuadaftarPage extends StatefulWidget {
  final String room;

  const SemuadaftarPage({super.key, required this.room});

  @override
  _SemuadaftarPageState createState() => _SemuadaftarPageState();
}

class Booking {
  final String id;
  final String studentName;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String ruangan;
  final String jumlahPengguna;
  final String keterangan;
  final String idStatus;
  final String alasanPenolakan;
  final String tipeRuang;
  final String grupPengguna;
  final String catatanKejadian;

  Booking({
    required this.id,
    required this.studentName,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruangan,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.idStatus,
    required this.alasanPenolakan,
    required this.tipeRuang,
    required this.grupPengguna,
    required this.catatanKejadian,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'].toString(),
      studentName: json['nama_peminjam'],
      grupPengguna: json['grup_pengguna'] ?? '',
      bookDate: json['tanggal'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      ruangan: json['ruangan'],
      tipeRuang: json['tipe_ruang'] ?? '',
      jumlahPengguna: json['jumlah_orang'].toString(),
      keterangan: json['keterangan'],
      idStatus: json['id_status'].toString(),
      alasanPenolakan: json['alasan_penolakan'] ?? '',
      catatanKejadian: json['catatan_kejadian'] ?? '',
    );
  }
}

class _SemuadaftarPageState extends State<SemuadaftarPage> {
  late Future<List<Booking>> _peminjamanFuture;
  late Future<List<Map<String, dynamic>>> _statusFuture;
  String? _selectedStatus;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = fetchPeminjaman();
    _statusFuture = getStatus(isActive: true);
  }

  Widget _buildStatusDropdown(bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: getStatus(isActive: isActive),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var statuses = snapshot.data!.where((status) => 
              status['fungsi'] == 'peminjaman' && 
              status['is_active'] == isActive
            ).toList();
            
            return DropdownButtonFormField<String>(
              value: null,
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
                 refreshPeminjaman(); 
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  void refreshPeminjaman() {
  setState(() {
    _peminjamanFuture = fetchPeminjaman();
    });
  }

  Future<List<Booking>> fetchPeminjaman() async {
    List<Map<String, dynamic>> peminjaman = await getPeminjaman(widget.room);
    return peminjaman.map((data) => Booking.fromJson(data)).toList();
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

  List<Booking> _filterBookings(List<Booking> bookings, bool isActive) {
    var filtered = bookings;
    
    // Filter by selected status if one is selected
    if (_selectedStatus != null) {
      filtered = filtered.where((booking) => 
        booking.idStatus.toString() == _selectedStatus
      ).toList();
    }

    // Filter by date range if selected
    if (_selectedDateRange != null) {
      filtered = filtered.where((booking) {
        final bookingDate = DateFormat('dd/MM/yyyy').parse(booking.bookDate);
        return bookingDate.isAfter(_selectedDateRange!.start) && 
               bookingDate.isBefore(_selectedDateRange!.end);
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
            'Semua Daftar Peminjaman',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFFF5833),
          iconTheme: const IconThemeData(
            color: Colors.white,
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
                    child: const Text('Pilih Rentang Waktu'),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearDateRange,
                        iconSize: 20.0,
                        color: Colors.red,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_selectedDateRange != null)
                    Expanded(
                      child: Text(
                        '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Sedang Berjalan tab
                  Column(
                    children: [
                      _buildStatusDropdown(true),
                      Expanded(
                        child: FutureBuilder<List<Booking>>(
                          future: _peminjamanFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (snapshot.hasData) {
                              var filteredBookings = _filterBookings(snapshot.data!, true);
                              return ListView.builder(
                                itemCount: filteredBookings.length,
                                itemBuilder: (context, index) {
                                  final booking = filteredBookings[index];
                                  return BookingCard(
                                    id: booking.id,
                                    studentName: booking.studentName,
                                    grupPengguna: booking.grupPengguna,
                                    inputDate: booking.bookDate,
                                    time: "${booking.jamMulai} - ${booking.jamSelesai}",
                                    timeStart: booking.jamMulai,
                                    timeEnd: booking.jamSelesai,
                                    description: booking.keterangan,
                                    ruangan: booking.ruangan,
                                    tipeRuang: booking.tipeRuang,
                                    groupSize: "${booking.jumlahPengguna} orang",
                                    onAccept: () {},
                                    onReject: () {},
                                    idStatus: booking.idStatus,
                                    alasanPenolakan: booking.alasanPenolakan,
                                    catatanKejadian: booking.catatanKejadian,
                                  );
                                },
                              );
                            }
                            return const Center(child: CircularProgressIndicator());
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
                        child: FutureBuilder<List<Booking>>(
                          future: _peminjamanFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (snapshot.hasData) {
                              var filteredBookings = _filterBookings(snapshot.data!, false);
                              return ListView.builder(
                                itemCount: filteredBookings.length,
                                itemBuilder: (context, index) {
                                  final booking = filteredBookings[index];
                                  return BookingCard(
                                    id: booking.id,
                                    studentName: booking.studentName,
                                    grupPengguna: booking.grupPengguna,
                                    inputDate: booking.bookDate,
                                    time: "${booking.jamMulai} - ${booking.jamSelesai}",
                                    timeStart: booking.jamMulai,
                                    timeEnd: booking.jamSelesai,
                                    description: booking.keterangan,
                                    ruangan: booking.ruangan,
                                    tipeRuang: booking.tipeRuang,
                                    groupSize: "${booking.jumlahPengguna} orang",
                                    onAccept: () {},
                                    onReject: () {},
                                    idStatus: booking.idStatus,
                                    alasanPenolakan: booking.alasanPenolakan,
                                    catatanKejadian: booking.catatanKejadian,
                                  );
                                },
                              );
                            }
                            return const Center(child: CircularProgressIndicator());
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