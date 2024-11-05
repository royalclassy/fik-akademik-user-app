import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/status_accept.dart';
import 'package:class_leap/src/custom_style/status_reject.dart';
import 'package:class_leap/src/custom_style/status_pending.dart';
import 'package:class_leap/src/screens/peminjaman/detail_peminjaman_screen.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';

class BookingCard extends StatelessWidget {
  final String ruangan;
  final String studentName;
  final String inputDate;
  final String time;
  final String groupSize;
  final Function onAccept;
  final Function onReject;
  final String status;

  const BookingCard({
    Key? key,
    required this.ruangan,
    required this.studentName,
    required this.inputDate,
    required this.time,
    required this.groupSize,
    required this.onAccept,
    required this.onReject,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              studentName: studentName,
              studentNim: DummyData.studentNim,
              inputDate: inputDate,
              ruangan: ruangan,
              bookDate: DummyData.bookDate,
              jamMulai: DummyData.jamMulai,
              jamSelesai: DummyData.jamSelesai,
              jumlahPengguna: DummyData.jumlahPengguna,
              keterangan: DummyData.keterangan,
              status: status,
              alasan: DummyData.alasan,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      studentName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(inputDate, style: TextStyle(fontSize: 14),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 18,),
                          SizedBox(width: 12),
                          Text(time, style: TextStyle(fontSize: 14),),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_pin, size: 18,),
                          SizedBox(width: 12),
                          Text(ruangan, style: TextStyle(fontSize: 14),),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.group, size: 18,),
                          SizedBox(width: 12),
                          Text(groupSize, style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    ],
                  ),
                  if (status == 'Diterima')
                    ButtonAccept(
                      label: 'Diterima',
                      onPressed: () => onAccept(),
                    ),
                  if (status == 'Ditolak')
                    ButtonReject(
                      label: 'Ditolak',
                      onPressed: () => onReject(),
                    ),
                  if (status == 'Menunggu')
                    ButtonPending(
                      label: 'Menunggu',
                      onPressed: () {},
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}