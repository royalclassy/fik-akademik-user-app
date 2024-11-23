import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

const String base_url = 'http://127.0.0.1:8000/api/';
late String endpoint;
late SharedPreferences prefs;

Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

Future<String?> getAccessToken() async {
  await initializePreferences();
  return prefs.getString('access_token');
}

Future<Map<String, String>> _getHeaders() async {
  final accessToken = await getAccessToken();

  if (base_url.contains('ngrok')) {
    return {
      'Authorization' : 'Bearer $accessToken',
      'ngrok-skip-browser-warning': '69420',
    };
  }
  return {
    'Authorization' : 'Bearer $accessToken',
  };
}

Future<void> saveTokenToPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', token);
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
    'role': 'user_dosen,user_mahasiswa,user_tendik',
  }, headers: await _getHeaders());
  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    String token = responseBody['token'];

    await saveTokenToPreferences(token);

    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
//INI BUAT KALO RAISHA GANYALAIN NGROK
// await Future.delayed(Duration(seconds: 1)); // Simulate network delay
// return 200; // Simulate a successful login response


Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Gagal mengambil data jadwal');
  }
}

Future<String> signUp(String nama, String nim, String email, String noTlp, String password, int role, int prodi) async {
  endpoint = 'sign_up';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'nama': nama,
    'nim': nim,
    'email': email,
    'no_tlp': noTlp,
    'password': password,
    'id_peran': role.toString(),
    'prodi': prodi.toString(),
  }, headers: await _getHeaders());
  print(response.body);

  var responseBody = json.decode(response.body);
  String token = responseBody['token'];

  await saveTokenToPreferences(token);

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
  }, headers: await _getHeaders());

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

Future<Map<int, String>> addPeminjaman(String idRuang, String tanggal, String jamMulai, String jamSelesai, String keterangan, String jumlahOrang) async {
  endpoint = 'peminjaman';

  var formattedTimes = formatTime(jamMulai, jamSelesai);

  print('formattedTimes: $formattedTimes');
  print({
    'id_ruang': idRuang,
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'keterangan': keterangan,
    'jumlah_orang': jumlahOrang,
  });

  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id_ruang': idRuang,
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'keterangan': keterangan,
    'jumlah_orang': jumlahOrang,
  }, headers: await _getHeaders());

  // Log the full response body
  // print('Response body: ${response.body}');

  // Attempt to parse the response body as JSON
  // var responseBody = json.decode(response.body);
  // print(responseBody);
  // return responseBody;
    if (response.statusCode == 200) {
    // Print the response body to understand its structure
    final responseBody = json.decode(response.body);
    print('responseBody: $responseBody');

    // Create a Map<int, String> from the response
    return {
      responseBody['peminjaman_id']: responseBody['message']
    };
  } else {
    throw Exception('Failed to add peminjaman');
  }
}

Future<List<Map<String, dynamic>>> getPeminjaman(String room) async {
  endpoint = 'peminjaman/$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to get data');
  }
}

Future<List> getRuang(String room) async {
  endpoint = 'ruangan?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List<Map<String, dynamic>>> getKendala(String room) async {
  endpoint = 'kendala/$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to get data');
  }
}

Future<List> getJenisKendala() async {
  endpoint = 'kendala/jenis';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List> getBentukKendala() async {
  endpoint = 'kendala/bentuk';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List> getPeminjamanStatistik(String room) async {
  endpoint = 'peminjaman/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  // print(response.body);
  var responseBody = json.decode(response.body);
  return responseBody['data'];
}

Future<List> getKendalaStatistik(String room) async {
  endpoint = 'kendala/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  // print(responseBody['data']);
  return responseBody['data'];
}

Future<Map<int, String>> createKendala(String idRuang, String idJenisKendala, String idBentukKendala, String deskripsi) async {
  endpoint = 'kendala';
  print('idRuang: $idRuang, $idJenisKendala, $idBentukKendala, $deskripsi');
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id_ruang': idRuang,
    'id_jenis_kendala': idJenisKendala,
    'id_bentuk_kendala': idBentukKendala,
    'deskripsi_kendala': deskripsi,
  }, headers: await _getHeaders());

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return {
      responseBody['kendala_id']: responseBody['message']
    };
  } else {
    throw Exception('Failed to create kendala');
  }
}

Future<Map<String, String>> updatePassword(String newPassword) async {
  endpoint = 'user/upadate/password';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'password': newPassword,
  }, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return {
      'message': 'Password updated successfully'
    };
  } else {
    throw Exception('Failed to update password');
  }
}

Future<Map<String, String>?> fetchUserData() async {
  endpoint = 'user';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  if (accessToken != null) {
    try {
      final response = await http.get(
        Uri.parse(base_url + endpoint),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return {
          'name': userData['nama'],
          'nim': userData['id'],
          'email': userData['email'],
          'prodi': userData['prodi'],
          'profil': userData['profil'],
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