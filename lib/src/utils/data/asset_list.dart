// asset_list.dart
import 'package:flutter/material.dart';

class AssetList extends StatelessWidget {
  final List<Map<String, dynamic>> assets;

  const AssetList({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: assets.map<Widget>((asset) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(asset['name']),
            Text(asset['amount'].toString()),
          ],
        );
      }).toList(),
    );
  }
}

// final lab = {
//   'title': 'Lab Komputer',
//   'assets': [
//     {'name': 'Meja Dosen', 'amount': 5},
//     {'name': 'Kursi Dosen', 'amount': 10},
//     {'name': 'Monitor', 'amount': 15},
//     // Add more assets as needed
//   ],
// };