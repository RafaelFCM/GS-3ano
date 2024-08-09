import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharmaconnect_project/screens/dashboard_screen/dashboard_screen.dart';

class CertificateScreen extends StatelessWidget {
  final int courseId;
  final String studentName;
  final int userId;

  CertificateScreen({
    required this.courseId,
    required this.studentName,
    required this.userId,
  });

  Future<Map<String, dynamic>?> _getCourseDetails() async {
    return await DBService().getCourse(courseId);
  }

  void _downloadCertificate(
      BuildContext context, Map<String, dynamic> course) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Nome do curso: ${course['title']}',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Descrição do curso: ${course['description']}'),
                pw.Text('Carga horária: ${course['duration']}'),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Nome completo do aluno: $studentName',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/certificado.pdf");
    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Certificado baixado com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getCourseDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Certificado'),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Certificado'),
            ),
            body: Center(child: Text('Erro ao carregar os dados do curso')),
          );
        }

        final course = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Certificado'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome do curso: ${course['title']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Descrição do curso: ${course['description']}'),
                      Text('Carga horária: ${course['duration']}'),
                      SizedBox(height: 20),
                      Text(
                        'Nome completo do aluno: $studentName',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _downloadCertificate(context, course),
                    child: Text('Download Certificado'),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DashboardScreen(userId: userId)),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Voltar para Dashboard'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
