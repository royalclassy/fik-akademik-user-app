import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/data/api_data.dart' as api_data;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _akademikPdfUrl;
  String? _fakultasPdfUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPdfs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPdfs() async {
    setState(() => _isLoading = true);
    try {
      _akademikPdfUrl = await api_data.getCalendarPDF('akademik');
      _fakultasPdfUrl = await api_data.getCalendarPDF('fakultas');
      print('PDFs loaded');
    } catch (e) {
      print('Error loading PDFs: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }
    
    Widget _buildPdfView(String? url) {
        if (url == null) {
        return const Center(
            child: Text('PDF tidak tersedia', style: TextStyle(fontSize: 16)),
        );
        }

        return Stack(
        children: [
            FutureBuilder<http.Response>(
            future: http.get(Uri.parse(url)),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                    color: Color(0xFFFF5833),
                    ),
                );
                }
                
                if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}', 
                    style: const TextStyle(color: Colors.red)
                    ),
                );
                }

                if (snapshot.hasData) {
                return PDFView(
                    pdfData: snapshot.data!.bodyBytes,
                    onError: (error) {
                    print('PDF Error: $error');
                    },
                    onPageError: (page, error) {
                    print('Page $page: $error');
                    },
                );
                }

                return const Center(
                child: Text('Failed to load PDF'),
                );
            },
            ),
        ],
        );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Kalender Akademik',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Universitas'),
            Tab(text: 'Fakultas'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF5833),
              ),
            )
          : TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPdfView(_akademikPdfUrl),
                _buildPdfView(_fakultasPdfUrl),
              ],
            ),
    );
  }
}