import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;

class BarChart extends StatefulWidget {
  final String room;
  final String type;

  const BarChart({
    super.key,
    required this.room,
    required this.type
  });

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<double> dataChart = [0,0,0,0,0];

  @override
  void initState() {
    super.initState();
    getStatistik();
  }

  Future<void> getStatistik() async {
    List<double> data;
    if (widget.type == 'peminjaman') {
      data = List<double>.from(await api_data.getPeminjamanStatistik(widget.room));
    } else {
      data = List<double>.from(await api_data.getKendalaStatistik(widget.room));
    }
    
    setState(() {
      dataChart = List<double>.from(data);
      while (dataChart.length < 5) {
        dataChart.add(0);
      }
    });
    // print(dataChart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Set the width to double infinity
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(
          color: const Color(0xff2f4858), // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: FlutterSalesGraph(
            salesData: dataChart,
            labels: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'],
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