import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pharmaconnect_project/models/settings_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _selectedLanguage;
  late String _selectedFontSize;
  late bool _emailNotifications;
  late bool _appNotifications;
  late bool _privacyOptions;

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingsModel>(context, listen: false);
    _selectedLanguage = settings.language;
    _selectedFontSize = settings.fontSize;
    _emailNotifications = settings.emailNotifications;
    _appNotifications = settings.appNotifications;
    _privacyOptions = settings.privacyOptions;
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Preferências do usuário'),
            SizedBox(height: 10),
            _buildDropdown(
              value: _selectedLanguage,
              label: 'Idioma:',
              items: ['Português', 'Inglês', 'Espanhol'],
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            SizedBox(height: 10),
            _buildDropdown(
              value: _selectedFontSize,
              label: 'Tamanho da fonte:',
              items: ['Pequena', 'Média', 'Grande'],
              onChanged: (value) {
                setState(() {
                  _selectedFontSize = value!;
                });
              },
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Configurações de Notificação'),
            _buildCheckbox(
              title: 'Notificações no email',
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value!;
                });
              },
            ),
            _buildCheckbox(
              title: 'Notificações no app',
              value: _appNotifications,
              onChanged: (value) {
                setState(() {
                  _appNotifications = value!;
                });
              },
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Opções de Privacidade'),
            _buildCheckbox(
              title: 'Não quero compartilhar minhas informações',
              value: _privacyOptions,
              onChanged: (value) {
                setState(() {
                  _privacyOptions = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _salvar(settings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      items: items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildCheckbox({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800]),
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blueGrey[300],
    );
  }

  void _salvar(SettingsModel settings) {
    settings.updateSettings(
      language: _selectedLanguage,
      fontSize: _selectedFontSize,
      emailNotifications: _emailNotifications,
      appNotifications: _appNotifications,
      privacyOptions: _privacyOptions,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Configurações salvas com sucesso!')),
    );
  }
}
