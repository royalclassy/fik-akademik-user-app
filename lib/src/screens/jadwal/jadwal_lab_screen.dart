import 'package:class_leap/src/custom_style/bar_chart.dart';
import 'package:class_leap/src/screens/pelaporan/form_pelaporan_kelas.dart';
import 'package:class_leap/src/screens/pelaporan/form_pelaporan_lab.dart';
import 'package:class_leap/src/screens/peminjaman/form_peminjaman_kelas.dart';
import 'package:class_leap/src/screens/peminjaman/form_peminjaman_lab.dart';
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/custom_style/custom_button.dart';
import 'package:class_leap/src/custom_style/custom_button_two.dart';
import 'package:class_leap/src/screens/jadwal/jadwal_kelas_screen.dart';
import 'package:class_leap/src/custom_style/card_confirmed.dart';
import 'package:class_leap/src/screens/jadwal/kode_dosen_mk_screen.dart';
import 'package:class_leap/src/screens/welcome/notification_screen.dart';
import 'package:class_leap/src/utils/data/dummy_data.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';

class JadwallabPage extends StatefulWidget {
  const JadwallabPage({Key? key}) : super(key: key);

  @override
  State<JadwallabPage> createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwallabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pemakaian Ruang Lab dan Kelas FIK UPNVJ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Jadwal Ruang Lab',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        label: 'Jadwal Ruang Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JadwalkelasPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButtonTwo(
                        label: 'Jadwal KRSku',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KodedosenmkPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Pelaporan Kendala Lab dan Kelas FIK',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Ajukan Kendala Lab',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LaporLab()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        label: 'Ajukan Kendala Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LaporKelas()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                CardConfirmed(
                  studentName: DummyData.studentName,
                  studentNim: DummyData.studentNim,
                  inputDate: DummyData.bookDate,
                  time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                  ruangan: DummyData.ruangan,
                  groupSize: "${DummyData.jumlahPengguna} orang",
                  isAccepted: true,
                  bookDate: '',
                  jamMulai: '',
                  jamSelesai: '',
                  jumlahPengguna: '',
                  keterangan: '',
                ),
                SizedBox(height: 20),
                CardConfirmed(
                  studentName: DummyData.studentName,
                  studentNim: DummyData.studentNim,
                  inputDate: DummyData.bookDate,
                  time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                  ruangan: DummyData.ruangan,
                  groupSize: "${DummyData.jumlahPengguna} orang",
                  isAccepted: true,
                  bookDate: '',
                  jamMulai: '',
                  jamSelesai: '',
                  jumlahPengguna: '',
                  keterangan: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}