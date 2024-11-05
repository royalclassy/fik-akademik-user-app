class DummyData {
  static const String studentName = 'John Doe';
  static const String studentNim = '123456789';
  static const String inputDate = '24/09/2024';
  static const String ruangan = 'Lab 301';
  static const String bookDate = '24/09/2024';
  static const String jamMulai = '09:00';
  static const String jamSelesai = '11:00';
  static const String jumlahPengguna = '30';
  static const String keterangan = 'Kegiatan belajar mengajar';
  static String alasan = 'Some reason';

  static List<Booking> bookings = [
    Booking(
      studentName: 'John Doe',
      bookDate: '24/09/2024',
      jamMulai: '09:00',
      jamSelesai: '11:00',
      ruangan: 'Lab 301',
      jumlahPengguna: '30',
      status: 'Diterima',
    ),
    Booking(
      studentName: 'Jane Smith',
      bookDate: '25/09/2024',
      jamMulai: '10:00',
      jamSelesai: '12:00',
      ruangan: 'Lab 302',
      jumlahPengguna: '25',
      status: 'Ditolak',
    ),
    Booking(
      studentName: 'Alice Johnson',
      bookDate: '26/09/2024',
      jamMulai: '11:00',
      jamSelesai: '13:00',
      ruangan: 'Lab 303',
      jumlahPengguna: '20',
      status: 'Menunggu',
    ),
    // Add more bookings as needed
  ];
}

class Booking {
  final String studentName;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String ruangan;
  final String jumlahPengguna;
  final String status;

  Booking({
    required this.studentName,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruangan,
    required this.jumlahPengguna,
    required this.status,
  });
}