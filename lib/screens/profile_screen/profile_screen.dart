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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Dados gerais'),
                _buildProfileField('Nome completo', profile['name'] ?? ''),
                _buildProfileField(
                    'Nome nos certificados', profile['certificateName'] ?? ''),
                _buildProfileField('E-mail', profile['email'] ?? ''),
                SizedBox(height: 20),
                _buildSectionTitle('Sobre você'),
                _buildProfileField('Biografia', profile['bio'] ?? ''),
                _buildProfileField(
                    'Data de nascimento', profile['birthDate'] ?? ''),
                _buildProfileField('Ocupação', profile['occupation'] ?? ''),
                _buildProfileField('Empresa', profile['company'] ?? ''),
                _buildProfileField('Cargo', profile['position'] ?? ''),
                SizedBox(height: 20),
                _buildSectionTitle('Suas redes'),
                _buildProfileField('Linkedin', profile['linkedin'] ?? ''),
                _buildProfileField('Twitter', profile['twitter'] ?? ''),
                SizedBox(height: 20),
                _buildSectionTitle('Seus projetos na web'),
                _buildProfileField('Github', profile['github'] ?? ''),
                _buildProfileField(
                    'Link personalizado', profile['customLink'] ?? ''),
                SizedBox(height: 20),
                _buildSectionTitle('Formação Acadêmica'),
                _buildProfileField('Curso', profile['course'] ?? ''),
                _buildProfileField('Instituição', profile['institution'] ?? ''),
                _buildProfileField('Tipo', profile['educationType'] ?? ''),
                _buildProfileField('Concluído',
                    (profile['isCompleted'] ?? 0) == 1 ? 'Sim' : 'Não'),
                SizedBox(height: 20),
                _buildSectionTitle('Tipo de Personalidade'),
                _buildProfileField(
                    'Tipo de Personalidade', profile['personalityType'] ?? ''),
                SizedBox(height: 20),
                _buildSectionTitle('Suas áreas de interesses'),
                _buildInterestsSection(
                    (profile['interests'] as String).split(',')),
              ],
            ),
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
