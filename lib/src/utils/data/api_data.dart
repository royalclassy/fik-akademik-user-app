import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:intl/intl.dart';

const String base_url = 'https://7ac2-180-252-80-71.ngrok-free.app/api/';
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

Future<int> login(String identifier, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'identifier' : identifier,
    'password': password,
    'role': 'user_dosen,user_mahasiswa,user_tendik',
  }, headers: await _getHeaders());
  print(response.body);
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
    print("data: $data");
    return data.cast<Map<String, dynamic>>();
  } else {
    print(response.body);
    throw Exception('Gagal mengambil data jadwal');
  }
}

Future<List<Map<String, dynamic>>> getProdi() async {
  endpoint = 'prodi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Gagal mengambil data prodi');
  }
}

Future<List<Map<String, dynamic>>> getPeranUser() async {
  endpoint = 'user/peran';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Gagal mengambil data peran user');
  }
}

Future<String> signUp(String nama, String nim, String email, String noTlp, String password, int role, int? prodi) async {
  endpoint = 'sign_up';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'nama': nama,
    'kode_user': nim,
    'email': email,
    'no_tlp': noTlp,
    'password': password,
    'id_peran': role.toString(),
    'id_prodi': prodi.toString(),
  }, headers: await _getHeaders());

  var responseBody = json.decode(response.body);
  String token = responseBody['token'];

  await saveTokenToPreferences(token);

  return responseBody['message'];
}

Future<Map<String, dynamic>> getAvailablity(String tanggal, String jamMulai, String jamSelesai, String idRuang, String jumlahOrang) async {
  endpoint = 'ketersediaan-ruangan';

  var formattedTimes = formatTime(jamMulai, jamSelesai);

  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tgl_pinjam': tanggal,
    'jam_mulai': formattedTimes['formattedStartTime']!,
    'jam_selesai': formattedTimes['formattedEndTime']!,
    'id_ruang': idRuang,
    'jumlah_orang': jumlahOrang,
  }, headers: await _getHeaders());

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    var isAvailable = responseBody['available'];
    var message = responseBody['message'];
    return {'available': isAvailable, 'message': message};
  } else {
    print('Error: ${response.statusCode}');
    return {'available': false, 'message': 'Error checking availability'};
  }
}

Future<Map<int, String>> addPeminjaman(String idRuang, String tanggal, String jamMulai, String jamSelesai, String keterangan, String jumlahOrang) async {
  endpoint = 'peminjaman';

  var formattedTimes = formatTime(jamMulai, jamSelesai);

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
  endpoint = 'ruangan';
  print(room);
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tipe_ruang':room,
  }, headers: await _getHeaders());
  print(response.body);
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<Map<String, dynamic>> getAssetDetails(String idRuangan) async {
  endpoint = 'ruangan/$idRuangan';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load asset details');
  }
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
  print(response.body);
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

Future<Map<int, String>> createKendala(String idRuang, String idAset, String deskripsi) async {
  endpoint = 'kendala';
  print("request : $idRuang, $idAset, $deskripsi");
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id_ruang': idRuang,
    'id_aset': idAset,
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
  endpoint = 'user/update/password';
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

Future<Map<String, dynamic>?> fetchUserData() async {
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
        return userData;
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

Future<Map<String, dynamic>> batalPeminjaman(String room) async {
  endpoint = 'peminjaman/batal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(
    url,
    body: {
      'id': room,
    },
    headers: await _getHeaders(),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to cancel peminjaman');
  }
}

Future<List<Map<String, dynamic>>> getAllProfildosen() async {
  endpoint = 'profildosen';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> updateProfile(String name, String nim, String email, String idProdi, File image) async {
  const String endpoint = 'user/update';
  final String url = base_url + endpoint;
  final headers = await _getHeaders();

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..fields['nama'] = name
      ..fields['nim'] = nim
      ..fields['email'] = email
      ..fields['id_prodi'] = idProdi;

    if (image.path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    var response = await request.send().timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      print('Profile updated successfully');
    } else {
      print('Failed to update profile: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      throw Exception('Failed to update profile');
    }
  } catch (e) {
    print('Error updating profile: $e');
    throw Exception('Error updating profile');
  }
}