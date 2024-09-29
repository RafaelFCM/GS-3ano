import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;

  ProfileScreen({required this.userId});

  Future<Map<String, dynamic>?> _loadProfile() async {
    final dbService = DBService();
    return await dbService.getProfile(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: Text('Erro ao carregar perfil.'));
        }

        final profile = snapshot.data;

        if (profile == null) {
          return Center(child: Text('Perfil não encontrado.'));
        }

        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionTitle('Dados gerais'),
              _buildProfileFieldWithNewLine('Nome completo', profile['name'] ?? ''),
              _buildProfileFieldWithNewLine(
                  'Nome nos certificados', profile['certificateName'] ?? ''),
              _buildProfileFieldWithNewLine('E-mail', profile['email'] ?? ''),
              SizedBox(height: 20),
              _buildSectionTitle('Sobre você'),
              _buildProfileFieldWithNewLine('Biografia', profile['bio'] ?? ''),
              _buildProfileFieldWithNewLine(
                  'Data de nascimento', profile['birthDate'] ?? ''),
              _buildProfileFieldWithNewLine('Ocupação', profile['occupation'] ?? ''),
              _buildProfileFieldWithNewLine('Empresa', profile['company'] ?? ''),
              _buildProfileFieldWithNewLine('Cargo', profile['position'] ?? ''),
              SizedBox(height: 20),
              _buildSectionTitle('Suas redes'),
              _buildProfileFieldWithNewLine('Linkedin', profile['linkedin'] ?? ''),
              _buildProfileFieldWithNewLine('Twitter', profile['twitter'] ?? ''),
              SizedBox(height: 20),
              _buildSectionTitle('Seus projetos na web'),
              _buildProfileFieldWithNewLine('Github', profile['github'] ?? ''),
              _buildProfileFieldWithNewLine(
                  'Link personalizado', profile['customLink'] ?? ''),
              SizedBox(height: 20),
              _buildSectionTitle('Formação Acadêmica'),
              _buildProfileFieldWithNewLine('Curso', profile['course'] ?? ''),
              _buildProfileFieldWithNewLine('Instituição', profile['institution'] ?? ''),
              _buildProfileFieldWithNewLine('Tipo', profile['educationType'] ?? ''),
              _buildProfileFieldWithNewLine('Concluído',
                  (profile['isCompleted'] ?? 0) == 1 ? 'Sim' : 'Não'),
              SizedBox(height: 20),
              _buildSectionTitle('Tipo de Personalidade'),
              _buildProfileFieldWithNewLine(
                  'Tipo de Personalidade', profile['personalityType'] ?? ''),
              SizedBox(height: 20),
              _buildSectionTitle('Suas áreas de interesses'),
              _buildInterestsSection(
                  (profile['interests'] as String).split(',')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[300]),
    );
  }

  Widget _buildProfileField(String field, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$field: ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[800]),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileFieldWithNewLine(String field, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$field:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[800]),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection(List<String> interests) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: interests.map((interest) {
        return Chip(
          label: Text(
            interest,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[300],
        );
      }).toList(),
    );
  }
}
