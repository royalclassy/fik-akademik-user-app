import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/booking_card.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';
import 'package:intl/intl.dart';

class SemuadaftarPage extends StatefulWidget {
  @override
  _SemuadaftarPageState createState() => _SemuadaftarPageState();
}

class _SemuadaftarPageState extends State<SemuadaftarPage> {
  String _selectedStatus = 'Diterima';
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

  List<Booking> _filterBookings(List<Booking> bookings) {
    if (_selectedDateRange == null) return bookings;
    return bookings.where((booking) {
      final bookingDate = DateFormat('dd/MM/yyyy').parse(booking.bookDate);
      return bookingDate.isAfter(_selectedDateRange!.start) &&
             bookingDate.isBefore(_selectedDateRange!.end);
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
            'Semua Daftar Peminjaman',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFFFF5833),
          iconTheme: IconThemeData(
            color: Colors.white, // Set all icons to white
          ),
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
                    child: Text('Select Date Range'),
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
                    child: _buildBookingList(
                      _filterBookings(DummyData.bookings)
                          .where((booking) => booking.status == 'Menunggu')
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
                          items: ['Diterima', 'Ditolak']
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
                          child: _buildBookingList(
                            _filterBookings(DummyData.bookings)
                                .where((booking) => booking.status == _selectedStatus)
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

  Widget _buildBookingList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return Center(child: Text('Tidak ada data'));
    }
    return ListView(
      children: bookings.map((booking) => BookingCard(
        studentName: booking.studentName,
        inputDate: booking.bookDate,
        time: "${booking.jamMulai} - ${booking.jamSelesai} WIB",
        ruangan: booking.ruangan,
        groupSize: "${booking.jumlahPengguna} orang",
        onAccept: () {},
        onReject: () {},
        status: booking.status,
      )).toList(),
    );
  }
}