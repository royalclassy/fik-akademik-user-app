// import 'package:flutter/material.dart';
// //import 'package:admin_fik_app/pages/datas/api_service.dart';
// import 'package:class_leap/src/custom_style/card_confirmed.dart';
//
// class TerkonfirmasiPage extends StatefulWidget {
//   @override
//   _TerkonfirmasiPageState createState() => _TerkonfirmasiPageState();
// }
//
// class _TerkonfirmasiPageState extends State<TerkonfirmasiPage> {
//   late Future<List<dynamic>> _confirmedBookings;
//
//   @override
//   void initState() {
//     super.initState();
//     final apiService = ApiService();
//     _confirmedBookings = apiService.fetchData('users');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Daftar Sudah Dikonfirmasi',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Color(0xFFFF58433),
//       ),
//       body: Container(
//         color: Colors.grey[200],
//         padding: EdgeInsets.all(16),
//         child: FutureBuilder<List<dynamic>>(
//           future: _confirmedBookings,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No data available'));
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final user = snapshot.data![index];
//                   return Column(
//                     children: [
//                       // CardConfirmed(
//                       //   studentName: user['nama'],
//                       //   inputDate: user['dibuat_pada'],
//                       //   time: user['dimodif_pada'],
//                       //   ruangan: user['prodi'],
//                       //   groupSize: user['no_tlp'],
//                       //   isAccepted: user['id_peran'] == 1,
//                       //   studentNim: user['nim'],
//                       //   bookDate: user['book_date'],
//                       //   jamMulai: user['jam_mulai'],
//                       //   jamSelesai: user['jam_selesai'],
//                       //   jumlahPengguna: user['jumlah_pengguna'],
//                       //   keterangan: user['keterangan'],
//                       // ),
//                       Text(user['nama']),
//                       SizedBox(height: 16),
//                     ],
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/card_confirmed.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';
//import 'package:admin_fik_app/pages/datas/api_service.dart';

class TerkonfirmasiPage extends StatefulWidget {
  const TerkonfirmasiPage({super.key});

  @override
  _TerkonfirmasiPageState createState() => _TerkonfirmasiPageState();
}

class _TerkonfirmasiPageState extends State<TerkonfirmasiPage> {
  // late Future<List<dynamic>> _confirmedBookings;

  @override
  void initState() {
    super.initState();
    // final apiService = ApiService();
    // _confirmedBookings = apiService.fetchData('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daftar Sudah Dikonfirmasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffff58433),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            CardConfirmed(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              isAccepted: true,
              // studentNim: DummyData.studentNim,
              bookDate: DummyData.bookDate,
              jamMulai: DummyData.jamMulai,
              jamSelesai: DummyData.jamSelesai,
              jumlahPengguna: DummyData.jumlahPengguna,
              keterangan: DummyData.keterangan,
            ),
            SizedBox(height: 16),
            CardConfirmed(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              isAccepted: false,
              // studentNim: DummyData.studentNim,
              bookDate: DummyData.bookDate,
              jamMulai: DummyData.jamMulai,
              jamSelesai: DummyData.jamSelesai,
              jumlahPengguna: DummyData.jumlahPengguna,
              keterangan: DummyData.keterangan,
            ),
          ],
        ),
        // child: FutureBuilder<List<dynamic>>(
        //   future: _confirmedBookings,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //       return Center(child: Text('No data available'));
        //     } else {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           final user = snapshot.data![index];
        //           return Column(
        //             children: [
        //               CardConfirmed(
        //                 studentName: user['nama'],
        //                 inputDate: user['dibuat_pada'],
        //                 time: user['dimodif_pada'],
        //                 ruangan: user['prodi'],
        //                 groupSize: user['no_tlp'],
        //                 isAccepted: user['id_peran'] == 1,
        //                 studentNim: user['nim'],
        //                 bookDate: user['book_date'],
        //                 jamMulai: user['jam_mulai'],
        //                 jamSelesai: user['jam_selesai'],
        //                 jumlahPengguna: user['jumlah_pengguna'],
        //                 keterangan: user['keterangan'],
        //               ),
        //               Text(user['nama']),
        //               SizedBox(height: 16),
        //             ],
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}