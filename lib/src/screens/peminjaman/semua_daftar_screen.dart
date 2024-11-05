import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/booking_card.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';

class SemuadaftarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'Diterima'),
              Tab(text: 'Ditolak'),
              Tab(text: 'Menunggu'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab for "Diterima"
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16),
              child: ListView(
                children: DummyData.bookings
                    .where((booking) => booking.status == 'Diterima')
                    .map((booking) => BookingCard(
                          studentName: booking.studentName,
                          inputDate: booking.bookDate,
                          time: "${booking.jamMulai} - ${booking.jamSelesai} WIB",
                          ruangan: booking.ruangan,
                          groupSize: "${booking.jumlahPengguna} Orang",
                          onAccept: () {},
                          onReject: () {},
                          status: 'Diterima',
                        ))
                    .toList(),
              ),
            ),
            // Tab for "Ditolak"
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16),
              child: ListView(
                children: DummyData.bookings
                    .where((booking) => booking.status == 'Ditolak')
                    .map((booking) => BookingCard(
                          studentName: booking.studentName,
                          inputDate: booking.bookDate,
                          time: "${booking.jamMulai} - ${booking.jamSelesai} WIB",
                          ruangan: booking.ruangan,
                          groupSize: "${booking.jumlahPengguna} Orang",
                          onAccept: () {},
                          onReject: () {},
                          status: 'Ditolak',
                        ))
                    .toList(),
              ),
            ),
            // Tab for "Menunggu"
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16),
              child: ListView(
                children: DummyData.bookings
                    .where((booking) => booking.status == 'Menunggu')
                    .map((booking) => BookingCard(
                          studentName: booking.studentName,
                          inputDate: booking.bookDate,
                          time: "${booking.jamMulai} - ${booking.jamSelesai} WIB",
                          ruangan: booking.ruangan,
                          groupSize: "${booking.jumlahPengguna} Orang",
                          onAccept: () {},
                          onReject: () {},
                          status: 'Menunggu',
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}