import 'package:flutter/material.dart';
// import 'package:class_leap/src/custom_style/status_accept.dart';
// import 'package:class_leap/src/custom_style/status_reject.dart';
// import 'package:class_leap/src/custom_style/status_pending.dart';
import 'package:class_leap/src/screens/peminjaman/detail_peminjaman_screen.dart';

class BookingCard extends StatelessWidget {
  final String id;
  final String ruangan;
  final String studentName;
  final String inputDate;
  final String time;
  final String timeStart;
  final String timeEnd;
  final String description;
  final String groupSize;
  final Function onAccept;
  final Function onReject;
  final String idStatus;
  final String alasanPenolakan;
  final String tipeRuang;
  final String grupPengguna;
  final String catatanKejadian;
  final VoidCallback onRefresh;

  const BookingCard({
    super.key,
    required this.id,
    required this.ruangan,
    required this.studentName,
    required this.inputDate,
    required this.time,
    required this.timeStart,
    required this.timeEnd,
    required this.description,
    required this.groupSize,
    required this.onAccept,
    required this.onReject,
    required this.idStatus,
    required this.alasanPenolakan,
    required this.tipeRuang,
    required this.grupPengguna,
    required this.catatanKejadian,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              idPeminjaman:id,
              studentName: studentName,
              // studentNim: DummyData.studentNim,
              // inputDate: inputDate,
              ruangan: ruangan,
              bookDate: inputDate,
              jamMulai: timeStart,
              jamSelesai: timeEnd,
              jumlahPengguna: groupSize,
              keterangan: description,
              idStatus: idStatus,
              alasan_penolakan: alasanPenolakan,
              tipeRuang: tipeRuang,
              grupPengguna: grupPengguna,
              catatanKejadian: catatanKejadian,
              // alasan: DummyData.alasan,
            ),
          ),
        ).then((result){
          if(result != null){
            onRefresh();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      },
      child: Card(
        elevation: 4,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(inputDate, style: const TextStyle(fontSize: 14),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 18,),
                          const SizedBox(width: 12),
                          Text(time, style: const TextStyle(fontSize: 14),),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_pin, size: 18,),
                          const SizedBox(width: 12),
                          Text(ruangan, style: const TextStyle(fontSize: 14),),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.group, size: 18,),
                          const SizedBox(width: 12),
                          Text(groupSize, style: const TextStyle(fontSize: 14),),
                        ],
                      ),
                    ],
                  ),
                //   if (status == 'Diterima')
                //     ButtonAccept(
                //       label: 'Diterima',
                //       onPressed: () => onAccept(),
                //     ),
                //   if (status == 'Ditolak')
                //     ButtonReject(
                //       label: 'Ditolak',
                //       onPressed: () => onReject(),
                //     ),
                //   if (status == 'Menunggu')
                //     ButtonPending(
                //       label: 'Menunggu',
                //       onPressed: () {},
                 //    ),
                 ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}