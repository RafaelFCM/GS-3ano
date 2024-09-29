import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageProgressAllScreen extends StatefulWidget {
  @override
  _ManageProgressAllScreen createState() => _ManageProgressAllScreen();
}

class _ManageProgressAllScreen extends State<ManageProgressAllScreen> {
  // Remove a necessidade de chamar o banco de dados para essa seção
  // Crie uma lista estática de cursos mais populares
  final List<Map<String, dynamic>> topCourses = [
    {'title': 'Curso de Farmácia Industrial', 'completed': 120},
    {'title': 'Curso de ITIL Foundation', 'completed': 95},
    {'title': 'Curso de Power BI', 'completed': 78},
    {'title': 'Curso de Segurança no Trabalho', 'completed': 65},
    {'title': 'Curso de Gestão de Projetos', 'completed': 85},
  ];

  bool isLoading = false; // Desativa o indicador de carregamento

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progresso Geral'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCards(),
                    SizedBox(height: 20),
                    Text(
                      'Top 5 Treinamentos Mais Populares',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildPopularCoursesTable(), // Tabela dos Top 5 cursos
                    SizedBox(height: 20),
                    _buildTrainingProgressPieChart(),
                    SizedBox(height: 40),
                    _buildMonthlyProgressLineChart(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSummaryCard('Iniciados', 400),
          SizedBox(width: 10),
          _buildSummaryCard('Em Processo', 200),
          SizedBox(width: 10),
          _buildSummaryCard('Concluídos', 120),
          SizedBox(width: 10),
          _buildSummaryCard('Certificados', 90),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count) {
    return Container(
      width: 150,
      child: Card(
        color: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                '$count',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mostra a tabela com os 5 cursos mais populares fixos
  Widget _buildPopularCoursesTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Cursos')),
        DataColumn(label: Text('Realizados')),
      ],
      rows: topCourses.map((course) {
        return DataRow(cells: [
          DataCell(Text(course['title'])),
          DataCell(Text(course['completed'].toString())),
        ]);
      }).toList(),
    );
  }

  // Demais widgets mantidos como estão
  Widget _buildTrainingProgressPieChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progresso dos Treinamentos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        CustomPaint(
          size: Size(200, 200),
          painter: PieChartPainter(
            values: [50, 30, 20],
            colors: [Colors.green, Colors.blue, Colors.grey],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyProgressLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progresso Mensal de Treinamentos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        CustomPaint(
          size: Size(200, 100),
          painter: LineChartPainter(
            values: [0.1, 0.3, 0.4, 0.6, 0.7, 0.9],
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  PieChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    double total = values.reduce((a, b) => a + b);
    double startAngle = -90.0;

    for (int i = 0; i < values.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      final sweepAngle = (values[i] / total) * 360.0;
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle * 3.1415927 / 180,
        sweepAngle * 3.1415927 / 180,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> values;

  LineChartPainter({required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height - (values[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
