import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

final String base_url = 'https://429b-180-252-160-189.ngrok-free.app/api/';
late String endpoint;

Future<int> login(String email, String password) async {
  // endpoint = 'login';
  // var url = Uri.parse(base_url + endpoint);
  // var response = await http.post(url, body: {
  //   'email': email,
  //   'password': password,
  // });
  // return response.statusCode;

  //INI BUAT KALO RAISHA GANYALAIN NGROK
  await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  return 200; // Simulate a successful login response

}

Future<String> signUp(String nama, String nim, String email, String no_tlp, String password, int role, int prodi)  async {
  endpoint= 'sign_up';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'nama': nama,
    'nim': nim,
    'email': email,
    'no_tlp': no_tlp,
    'password': password,
    'id_peran': role.toString(),
    'prodi': prodi.toString(),
  });
  //get user_id from response
  var responseBody = json.decode(response.body);
  return responseBody['user_id'].toString();
}

Future<bool> getAvailablity(String tanggal, String jamMulai, String jamSelesai, String idRuang) async {
  endpoint = 'ketersediaan-ruangan';

  print('jam_mulai = $jamMulai');
  print('jam_selesai = $jamSelesai');

  // Convert time to HH:MM:SS format
  DateFormat inputFormat = DateFormat.jm(); // 4 AM format
  DateFormat outputFormat = DateFormat('HH:mm:ss'); // HH:MM:SS format

  print('Input Format: ${inputFormat.pattern}');
  print('Output Format: ${outputFormat.pattern}');

  // Trim the input strings to remove any leading or trailing whitespace
  jamMulai = jamMulai.trim();
  jamSelesai = jamSelesai.trim();

  print('Jam Mulai: $jamMulai');
  print('Jam Selesai: $jamSelesai');

  DateTime startTime = inputFormat.parse(jamMulai);
  DateTime endTime = inputFormat.parse(jamSelesai);

  print('Start Time: $startTime');
  print('End Time: $endTime');

  String formattedStartTime = outputFormat.format(startTime);
  String formattedEndTime = outputFormat.format(endTime);

  print('Start Time: $formattedStartTime');
  print('End Time: $formattedEndTime');

  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedStartTime,
    'jam_selesai': formattedEndTime,
    'id_ruang': idRuang,
  });

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    var isAvailable = responseBody['available'];
    return isAvailable;
  } else {
    print('Error: ${response.statusCode}');
    return false;
  }
}

  Future<int> addPeminjaman(String idUser, String idRuang, String tanggal, String jamMulai, String jamSelesai, String keterangan, String jumlahOrang) async {
    endpoint = 'peminjaman';
    var url = Uri.parse(base_url + endpoint);
    var response = await http.post(url
      , body: {
        'id_user': idUser,
        'id_ruang': idRuang,
        'tgl_pinjam': tanggal,
        'jam_mulai': jamMulai,
        'jam_selesai': jamSelesai,
          'keterangan': keterangan,
          'jumlah_orang': jumlahOrang,
      }
    );
    return response.statusCode;
  }

Future<List> getRuang() async {
  endpoint = 'ruangan';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url);
  var responseBody = json.decode(response.body);
  return responseBody;
}

