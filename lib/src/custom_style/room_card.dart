// lib/customstyle/roomCard.dart
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String idRuang;
  final String namaRuang;

  const RoomCard({
    Key? key,
    required this.idRuang,
    required this.namaRuang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(idRuang),
        subtitle: Text(namaRuang),
      ),
    );
  }
}