import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

final String base_url = 'https://dfca-180-252-162-159.ngrok-free.app/api/';
late String endpoint;

Map<String, String> _getHeaders() {
  if (base_url.contains('ngrok')) {
    return {
      'ngrok-skip-browser-warning': '69420',
    };
  }
  return {};
}

Future<void> saveNimToPreferences(String nim) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('nim', nim);
}

Map<String, String> formatTime(String jamMulai, String jamSelesai) {
  jamMulai = jamMulai.trim();
  jamSelesai = jamSelesai.trim();

  DateFormat inputFormat = DateFormat('HH:mm');
  DateFormat outputFormat = DateFormat('HH:mm:ss');

  DateTime startTime = inputFormat.parse(jamMulai);
  DateTime endTime = inputFormat.parse(jamSelesai);

  String formattedStartTime = outputFormat.format(startTime);
  String formattedEndTime = outputFormat.format(endTime);

  return {
    'formattedStartTime': formattedStartTime,
    'formattedEndTime': formattedEndTime,
  };
}

Future<int> login(String email, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'email': email,
    'password': password,
  }, headers: _getHeaders());
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    String nim = responseBody['nim'];

    await saveNimToPreferences(nim);

    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
//INI BUAT KALO RAISHA GANYALAIN NGROK
// await Future.delayed(Duration(seconds: 1)); // Simulate network delay
// return 200; // Simulate a successful login response


Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'admin/jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Gagal mengambil data jadwal');
  }
}

Future<String> signUp(String nama, String nim, String email, String no_tlp, String password, int role, int prodi) async {
  endpoint = 'sign_up';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'nama': nama,
    'nim': nim,
    'email': email,
    'no_tlp': no_tlp,
    'password': password,
    'id_peran': role.toString(),
    'prodi': prodi.toString(),
  }, headers: _getHeaders());
  print(response.body);

  var responseBody = json.decode(response.body);
  String nimFromResponse = responseBody['nim'];

  await saveNimToPreferences(nimFromResponse);

  return responseBody['message'];
}

Future<bool> getAvailablity(String tanggal, String jamMulai, String jamSelesai, String idRuang) async {
  endpoint = 'ketersediaan-ruangan';

  var formattedTimes = formatTime(jamMulai, jamSelesai);

  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'id_ruang': idRuang,
  }, headers: _getHeaders());

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    var isAvailable = responseBody['available'];
    print("responseBody: $responseBody");
    return isAvailable;
  } else {
    print('Error: ${response.statusCode}');
    return false;
  }
}

Future<Map<int, String>> addPeminjaman(String idUser, String idRuang, String tanggal, String jamMulai, String jamSelesai, String keterangan, String jumlahOrang) async {
  endpoint = 'peminjaman';

  var formattedTimes = formatTime(jamMulai, jamSelesai);

  print('formattedTimes: $formattedTimes');
  print({
    'id_user': idUser,
    'id_ruang': idRuang,
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'keterangan': keterangan,
    'jumlah_orang': jumlahOrang,
  });

  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id_user': idUser,
    'id_ruang': idRuang,
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'keterangan': keterangan,
    'jumlah_orang': jumlahOrang,
  }, headers: _getHeaders());

  // Log the full response body
  print('Response body: ${response.body}');

  // Attempt to parse the response body as JSON
  var responseBody = json.decode(response.body);
  print(responseBody);
  return responseBody;
}

Future<List> getRuang() async {
  endpoint = 'ruangan';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<Map<String, String>?> fetchUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('nim');
  if (userId != null) {
    try {
      final response = await http.get(
        Uri.parse('https://dfca-180-252-162-159.ngrok-free.app/api/user/$userId'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return {
          'name': userData['nama'],
          'nim': userData['id_user'],
          'email': userData['email'],
          'prodi': userData['prodi'],
        };
      } else {
        print('Failed to load user data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  return null;
}