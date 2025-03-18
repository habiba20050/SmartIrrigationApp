import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class IrrigaSchedulePage extends StatefulWidget {
  const IrrigaSchedulePage({super.key});

  @override
  _IrrigaSchedulePageState createState() => _IrrigaSchedulePageState();
}

class _IrrigaSchedulePageState extends State<IrrigaSchedulePage> {
  List<String> pdfFiles = [];
  String searchQuery = '';

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        pdfFiles.add(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Irrigation Schedule',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B401D),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search PDFs...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF255929)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickPDF,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF255929),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Upload PDF', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: pdfFiles.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Watering-Schedule-2.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No PDF files uploaded yet.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              )
                  : ListView.builder(
                itemCount: pdfFiles.length,
                itemBuilder: (context, index) {
                  final fileName = pdfFiles[index].split('/').last;
                  if (searchQuery.isNotEmpty && !fileName.toLowerCase().contains(searchQuery)) {
                    return const SizedBox();
                  }
                  return Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                      title: Text(
                        fileName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF1B401D)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(pdfPath: pdfFiles[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View PDF',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B401D),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SfPdfViewer.file(File(pdfPath)),
    );
  }
}
