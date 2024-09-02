import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageProgressAllScreen extends StatefulWidget {
  @override
  _ManageProgressAllScreen createState() => _ManageProgressAllScreen();
}

class _ManageProgressAllScreen extends State<ManageProgressAllScreen> {
  List<Map<String, dynamic>> coursesStats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrainingStats();
  }

  Future<void> _loadTrainingStats() async {
    final dbService = DBService();
    // Suponha que este método forneça uma lista de cursos com o número de alunos em andamento, concluídos, etc.
    coursesStats = await dbService.getCoursesStats();
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummaryCard('Certificados', 120), // Número fictício
        _buildSummaryCard('Em andamento', 200), // Número fictício
        _buildSummaryCard('Concluídos', 80), // Número fictício
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count) {
    return Card(
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '$count',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCoursesTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Treinamento')),
        DataColumn(label: Text('Realizados')),
      ],
      rows: coursesStats.map((course) {
        return DataRow(cells: [
          DataCell(Text(course['title'] ?? 'Título não disponível')),
          DataCell(Text(course['completed'].toString())),
        ]);
      }).toList(),
    );
  }

  Widget _buildCoursesPopularityChart(Map<String, int> courseData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popularidade dos Cursos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...courseData.keys.map((course) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(course)),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 20,
                    color: Colors.blue,
                    width: courseData[course]?.toDouble(),
                  ),
                ),
                SizedBox(width: 10),
                Text('${courseData[course]}'),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

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
            values: [
              50,
              30,
              20
            ], // Dados fictícios: Concluídos, Em andamento, Não iniciados
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
            values: [0.1, 0.3, 0.4, 0.6, 0.7, 0.9], // Dados fictícios
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Análise de Treinamentos'),
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
                      'Treinamentos mais populares',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildPopularCoursesTable(),
                    SizedBox(height: 20),
                    Text(
                      'Comparativo de Cursos Concluídos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildCoursesPopularityChart({
                      'Curso de Farmácia Industrial': 120,
                      'Curso de ITIL Foundation': 95,
                      'Curso de Compliance': 78,
                      'Curso de Segurança no Trabalho': 65,
                      'Curso de Gestão de Projetos': 85,
                    }),
                    SizedBox(height: 40),
                    _buildTrainingProgressPieChart(),
                    SizedBox(height: 40),
                    _buildMonthlyProgressLineChart(),
                  ],
                ),
              ),
            ),
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
