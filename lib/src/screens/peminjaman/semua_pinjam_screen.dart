import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/booking_card.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

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
      idStatus: json['id_status'],
      alasanPenolakan: json['alasan_penolakan'] ?? '',
      catatanKejadian: json['catatan_kejadian'] ?? '',
    );
  }
}

class _SemuadaftarPageState extends State<SemuadaftarPage> {
  late Future<List<Booking>> _peminjamanFuture;
  String _selectedStatus = 6.toString();
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = fetchPeminjaman();
  }

  Future<List<Booking>> fetchPeminjaman() async {
    List<Map<String, dynamic>> peminjaman;
    peminjaman = await api_data.getPeminjaman(widget.room);
    print("Peminjaman: $peminjaman");
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

List<Booking> _filterBookings(List<Booking> bookings) {
  if (_selectedDateRange == null) return bookings;
  return bookings.where((booking) {
    final bookingDate = DateFormat('dd/MM/yyyy').parse(booking.bookDate);
    print('Booking Date: $bookingDate');
    print('Start Date: ${_selectedDateRange!.start}');
    print('End Date: ${_selectedDateRange!.end}');
    return (bookingDate.isAfter(_selectedDateRange!.start) || bookingDate.isAtSameMomentAs(_selectedDateRange!.start)) &&
           (bookingDate.isBefore(_selectedDateRange!.end) || bookingDate.isAtSameMomentAs(_selectedDateRange!.end));
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
            'Semua Daftar Peminjaman',
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
                    child: FutureBuilder<List<Booking>>(
                      future: _peminjamanFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada data peminjaman'));
                        } else {
                          List<Booking> bookings = _filterBookings(
                              snapshot.data!);
                          bookings = bookings.where((booking) =>
                          booking.idStatus == 1).toList();
                          return ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              Booking booking = bookings[index];
                              return BookingCard(
                                id: booking.id,
                                studentName: booking.studentName,
                                grupPengguna: booking.grupPengguna,
                                inputDate: booking.bookDate,
                                time: "${booking.jamMulai} - ${booking
                                    .jamSelesai}",
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
                              value: 'disetujui',
                              child: Text('Disetujui'),
                            ),
                            DropdownMenuItem(
                              value: 'ditolak',
                              child: Text('Ditolak'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: FutureBuilder<List<Booking>>(
                            future: _peminjamanFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('Tidak ada data peminjaman'));
                              } else {
                                List<Booking> bookings = _filterBookings(
                                    snapshot.data!);
                                bookings = bookings.where((booking) => booking
                                    .id  == _selectedStatus).toList();
                                return ListView.builder(
                                  itemCount: bookings.length,
                                  itemBuilder: (context, index) {
                                    Booking booking = bookings[index];
                                    return BookingCard(
                                      id: booking.id,
                                      studentName: booking.studentName,
                                      grupPengguna: booking.grupPengguna,
                                      inputDate: booking.bookDate,
                                      time: "${booking.jamMulai} - ${booking
                                          .jamSelesai}",
                                      timeStart: booking.jamMulai,
                                      timeEnd: booking.jamSelesai,
                                      description: booking.keterangan,
                                      ruangan: booking.ruangan,
                                      tipeRuang: booking.tipeRuang,
                                      groupSize: "${booking
                                          .jumlahPengguna} orang",
                                      onAccept: () {},
                                      onReject: () {},
                                      idStatus: booking.idStatus,
                                      alasanPenolakan: booking.alasanPenolakan,
                                      catatanKejadian: booking.catatanKejadian,
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
  }}