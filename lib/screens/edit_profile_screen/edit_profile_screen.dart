import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/login_screen/forgot_password_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class EditProfileScreen extends StatefulWidget {
  final int userId;

  EditProfileScreen({required this.userId});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController certificateNameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late TextEditingController birthDateController;
  late TextEditingController occupationController;
  late TextEditingController companyController;
  late TextEditingController positionController;
  late TextEditingController linkedinController;
  late TextEditingController twitterController;
  late TextEditingController githubController;
  late TextEditingController customLinkController;
  late TextEditingController courseController;
  late TextEditingController institutionController;
  late TextEditingController educationTypeController;
  late TextEditingController newInterestController;
  bool isCompleted = false;
  List<String> selectedInterests = [];
  List<Map<String, dynamic>> additionalFormations = [];

  @override
  void initState() {
    super.initState();
    newInterestController = TextEditingController();

    // Inicialize os controladores de texto com valores vazios
    nameController = TextEditingController();
    certificateNameController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    birthDateController = TextEditingController();
    occupationController = TextEditingController();
    companyController = TextEditingController();
    positionController = TextEditingController();
    linkedinController = TextEditingController();
    twitterController = TextEditingController();
    githubController = TextEditingController();
    customLinkController = TextEditingController();
    courseController = TextEditingController();
    institutionController = TextEditingController();
    educationTypeController = TextEditingController();

    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final dbService = DBService();
    final profile = await dbService.getProfile(widget.userId);

    if (profile != null) {
      setState(() {
        nameController.text = profile['name'] ?? '';
        certificateNameController.text = profile['certificateName'] ?? '';
        emailController.text = profile['email'] ?? '';
        bioController.text = profile['bio'] ?? '';
        birthDateController.text = profile['birthDate'] ?? '';
        occupationController.text = profile['occupation'] ?? '';
        companyController.text = profile['company'] ?? '';
        positionController.text = profile['position'] ?? '';
        linkedinController.text = profile['linkedin'] ?? '';
        twitterController.text = profile['twitter'] ?? '';
        githubController.text = profile['github'] ?? '';
        customLinkController.text = profile['customLink'] ?? '';
        courseController.text = profile['course'] ?? '';
        institutionController.text = profile['institution'] ?? '';
        educationTypeController.text = profile['educationType'] ?? '';
        isCompleted = (profile['isCompleted'] ?? 0) == 1;
        selectedInterests = (profile['interests'] ?? '')
            .split(',')
            .where((e) => e.isNotEmpty)
            .toList();
      });
    }
  }

  void _addInterest() {
    if (newInterestController.text.isNotEmpty) {
      setState(() {
        selectedInterests.add(newInterestController.text);
        newInterestController.clear();
      });
    }
  }

  void _removeInterest(String interest) {
    setState(() {
      selectedInterests.remove(interest);
    });
  }

  void _addNewFormation() {
    setState(() {
      additionalFormations.add({
        'course': TextEditingController(),
        'institution': TextEditingController(),
        'type': TextEditingController(),
        'isCompleted': false,
      });
    });
  }

  void _removeFormation(int index) {
    setState(() {
      additionalFormations.removeAt(index);
    });
  }

  Future<void> _saveProfile() async {
    final dbService = DBService();
    await dbService.saveProfile({
      'userId': widget.userId,
      'name': nameController.text,
      'certificateName': certificateNameController.text,
      'bio': bioController.text,
      'birthDate': birthDateController.text,
      'occupation': occupationController.text,
      'company': companyController.text,
      'position': positionController.text,
      'linkedin': linkedinController.text,
      'twitter': twitterController.text,
      'github': githubController.text,
      'customLink': customLinkController.text,
      'course': courseController.text,
      'institution': institutionController.text,
      'educationType': educationTypeController.text,
      'isCompleted': isCompleted ? 1 : 0,
      'interests': selectedInterests.join(','),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
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
            _buildSectionTitle('Dados gerais'),
            _buildGeneralDataSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Sobre você'),
            _buildAboutSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Suas redes'),
            _buildSocialLinksSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Seus projetos na web'),
            _buildProjectsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Formação Acadêmica'),
            _buildEducationSection(),
            _buildNewFormationsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Suas áreas de interesses'),
            _buildInterestsSection(),
            SizedBox(height: 20),
            _buildSaveButton(),
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
        color: Colors.blueGrey[700],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildGeneralDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        _buildTextField('Nome completo', nameController),
        SizedBox(height: 10),
        _buildTextField('Nome nos certificados (alteração somente 1 vez)',
            certificateNameController),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
          child: Text(
            'Alterar senha',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Biografia', bioController),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildTextField('Data de nascimento', birthDateController),
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildTextField('Ocupação', occupationController),
        SizedBox(height: 10),
        _buildTextField('Empresa', companyController),
        SizedBox(height: 10),
        _buildTextField('Cargo', positionController),
      ],
    );
  }

  Widget _buildSocialLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Linkedin (link completo)', linkedinController),
        SizedBox(height: 10),
        _buildTextField('Twitter (link completo)', twitterController),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Github (link completo)', githubController),
        SizedBox(height: 10),
        _buildTextField(
            'Link personalizado (link completo)', customLinkController),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Curso', courseController),
        SizedBox(height: 10),
        _buildTextField('Instituição', institutionController),
        SizedBox(height: 10),
        _buildTextField('Tipo', educationTypeController),
        SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: (value) {
                setState(() {
                  isCompleted = value!;
                });
              },
            ),
            Text('Concluído'),
          ],
        ),
      ],
    );
  }

  Widget _buildNewFormationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: additionalFormations.length,
          itemBuilder: (context, index) {
            return _buildFormationCard(index);
          },
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addNewFormation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[300],
          ),
          child: Text('+ Nova Formação'),
        ),
      ],
    );
  }

  Widget _buildFormationCard(int index) {
    final formation = additionalFormations[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Curso', formation['course']),
            SizedBox(height: 10),
            _buildTextField('Instituição', formation['institution']),
            SizedBox(height: 10),
            _buildTextField('Tipo', formation['type']),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: formation['isCompleted'],
                  onChanged: (value) {
                    setState(() {
                      formation['isCompleted'] = value!;
                    });
                  },
                ),
                Text('Concluído'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeFormation(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: newInterestController,
          decoration: InputDecoration(
            labelText: 'Novo Interesse',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addInterest,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[300],
          ),
          child: Text('Adicionar Interesse'),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: selectedInterests.map((interest) {
            return Chip(
              label: Text(interest),
              deleteIcon: Icon(Icons.delete),
              onDeleted: () => _removeInterest(interest),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _saveProfile();
          Navigator.pop(context);
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
    );
  }
}
