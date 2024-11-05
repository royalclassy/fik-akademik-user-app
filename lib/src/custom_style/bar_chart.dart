import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Set the width to double infinity
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(
          color: Color(0xFFFFBE33), // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FlutterSalesGraph(
            salesData: [100, 200, 150, 300, 250, 350],
            labels: ['Sen', 'Sel', 'Rabu', 'Kam', 'Jum', 'Sab'],
            maxBarHeight: 250.0,
            barWidth: 36.0,
            colors: [Color(0xff3e537e), Color(0xff735596), Color(0xffb54a91)],
            dateLineHeight: 20.0,
          ),
        ),
      ),
    );
  }
}