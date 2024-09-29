import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  static Database? _database;

  DBService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pharmaconnect.db');
    return await openDatabase(
      path,
      version: 2, // Atualizado para a nova versão do banco de dados
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  //CRIANDO AS TABELAS DO PROJETO
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        points INTEGER NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE profiles(
        userId INTEGER PRIMARY KEY,
        name TEXT,
        certificateName TEXT,
        email TEXT,
        bio TEXT,
        birthDate TEXT,
        occupation TEXT,
        company TEXT,
        position TEXT,
        linkedin TEXT,
        twitter TEXT,
        github TEXT,
        customLink TEXT,
        course TEXT,
        institution TEXT,
        educationType TEXT,
        isCompleted INTEGER,
        interests TEXT,
        personalityType TEXT,
        hasCompletedTest INTEGER DEFAULT 0,
        FOREIGN KEY (userId) REFERENCES users (userId)
      )
    ''');
    await db.execute('''
      CREATE TABLE topics(
        topicId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE courses(
        courseId INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        imageUrl TEXT,
        instructors TEXT,
        duration TEXT,
        topicId INTEGER,
        FOREIGN KEY (topicId) REFERENCES topics(topicId)
      )
    ''');
    await db.execute('''
      CREATE TABLE lessons(
        lessonsId INTEGER PRIMARY KEY AUTOINCREMENT,
        courseId INTEGER,
        title TEXT,
        description TEXT,
        videoUrl TEXT,
        FOREIGN KEY (courseId) REFERENCES courses (courseId)
      )
    ''');
    await db.execute('''
        CREATE TABLE user_courses (
          userId INTEGER,
          courseId INTEGER,
          progress REAL,
          status TEXT,
          PRIMARY KEY (userId, courseId),
          FOREIGN KEY(userId) REFERENCES users(userId),
          FOREIGN KEY(courseId) REFERENCES courses(courseId)
        )
        ''');
    await db.execute('''
        CREATE TABLE user_lessons (
          userId INTEGER,
          courseId INTEGER,
          lessonId INTEGER,
          PRIMARY KEY (userId, courseId, lessonId),
          FOREIGN KEY (userId) REFERENCES users(userId),
          FOREIGN KEY (courseId) REFERENCES courses(courseId),
          FOREIGN KEY (lessonId) REFERENCES lessons(lessonId)
        )
        ''');

    //INSERINDO INFORMACOES NAS TABELAS CRIADAS

    // Insert inicial para usuários
    await db.insert(
        'users', {'email': 'suporte@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'lucas.silva@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'mariana.alves@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'joao.pereira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'renata.souza@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'carlos.ferreira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'patricia.rocha@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'rafael.martins@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'fernanda.machado@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'roberto.costa@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'juliana.melo@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'antonio.ramos@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'camila.silveira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'eduardo.lima@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'roberta.nogueira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'daniel.barros@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'aline.santos@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'mario.andrade@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'bruna.lopes@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'henrique.teixeira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'ana.moura@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'vinicius.gomes@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'carla.monteiro@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'guilherme.ribeiro@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'nathalia.soares@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'diego.barbosa@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'vanessa.pinto@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'leandro.campos@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'priscila.rodrigues@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'marcos.batista@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'diana.almeida@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'felipe.carvalho@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'thais.miranda@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'rodrigo.moreira@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'luciana.freitas@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'bruno.dias@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'leticia.castro@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'anderson.oliveira@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'sabrina.reis@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'gilberto.fonseca@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'raquel.pires@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'fabio.martinez@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'andrea.martins@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'gustavo.lima@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'laura.silva@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'paulo.vieira@eurofarma.com', 'password': '1234'});
    await db.insert('users',
        {'email': 'cristina.araujo@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'tiago.ribeiro@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'luana.torres@eurofarma.com', 'password': '1234'});
    await db.insert(
        'users', {'email': 'rafael.fiel@eurofarma.com', 'password': '1234'});

    // Insert inicial com infos dos usuários
    await db.insert('profiles', {
      'userId': 2,
      'name': 'Lucas Silva',
      'certificateName': 'Lucas Silva',
      'email': 'lucas.silva@eurofarma.com',
      'bio': 'Engenheiro apaixonado por inovação e tecnologia.',
      'birthDate': '15-03-1985',
      'occupation': 'Engenheiro',
      'company': 'Eurofarma',
      'position': 'Engenheiro de Projetos',
      'linkedin': 'https://www.linkedin.com/in/lucassilva',
      'twitter': 'https://twitter.com/lucassilva',
      'github': 'https://github.com/lucassilva',
      'customLink': '',
      'course': 'Engenharia Mecânica',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Inovação, Automação, Projetos Complexos',
      'personalityType': 'ENTJ',
    });
    
    await db.insert('profiles', {
      'userId': 3,
      'name': 'Mariana Alves',
      'certificateName': 'Mariana Alves',
      'email': 'mariana.alves@eurofarma.com',
      'bio':
          'Especialista em Marketing Digital com foco em estratégias inovadoras.',
      'birthDate': '12-06-1990',
      'occupation': 'Especialista em Marketing Digital',
      'company': 'Eurofarma',
      'position': 'Gerente de Marketing Digital',
      'linkedin': 'https://www.linkedin.com/in/marianaalves',
      'twitter': 'https://twitter.com/marianaalves',
      'github': '',
      'customLink': 'https://marianaalves.com.br',
      'course': 'Publicidade e Propaganda',
      'institution': 'ESPM',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Marketing, E-commerce, Inovação',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 4,
      'name': 'João Pereira',
      'certificateName': 'João Pereira',
      'email': 'joao.pereira@eurofarma.com',
      'bio': 'Gerente de logística com 15 anos de experiência no setor.',
      'birthDate': '08-11-1980',
      'occupation': 'Gerente de Logística',
      'company': 'Eurofarma',
      'position': 'Gerente de Logística e Distribuição',
      'linkedin': 'https://www.linkedin.com/in/joaopereira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Gestão de Ativos, Logística, Processos',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 5,
      'name': 'Renata Souza',
      'certificateName': 'Renata Souza',
      'email': 'renata.souza@eurofarma.com',
      'bio':
          'Especialista em auditoria interna, garantindo conformidade e segurança nos processos.',
      'birthDate': '21-01-1988',
      'occupation': 'Auditoria Interna',
      'company': 'Eurofarma',
      'position': 'Analista de Auditoria Interna',
      'linkedin': 'https://www.linkedin.com/in/renatasouza',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Ciências Contábeis',
      'institution': 'Universidade Federal do Rio de Janeiro',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Auditoria, Gestão de Riscos, Conformidade',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 6,
      'name': 'Carlos Ferreira',
      'certificateName': 'Carlos Ferreira',
      'email': 'carlos.ferreira@eurofarma.com',
      'bio':
          'Desenvolvedor apaixonado por inovação tecnológica e boas práticas de código.',
      'birthDate': '07-09-1992',
      'occupation': 'Desenvolvedor de Software',
      'company': 'Eurofarma',
      'position': 'Desenvolvedor Full Stack',
      'linkedin': 'https://www.linkedin.com/in/carlosferreira',
      'twitter': 'https://twitter.com/carlosdev',
      'github': 'https://github.com/carlosferreira',
      'customLink': '',
      'course': 'Ciência da Computação',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Desenvolvimento Web, IA, DevOps',
      'personalityType': 'INTP',
    });

    await db.insert('profiles', {
      'userId': 7,
      'name': 'Patricia Rocha',
      'certificateName': 'Patricia Rocha',
      'email': 'patricia.rocha@eurofarma.com',
      'bio':
          'Gerente de projetos com vasta experiência na gestão de equipes multidisciplinares.',
      'birthDate': '15-05-1987',
      'occupation': 'Gerente de Projetos',
      'company': 'Eurofarma',
      'position': 'Gerente de Projetos',
      'linkedin': 'https://www.linkedin.com/in/patriciarocha',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Gestão de Projetos, Metodologias Ágeis, Liderança',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 8,
      'name': 'Rafael Martins',
      'certificateName': 'Rafael Martins',
      'email': 'rafael.martins@eurofarma.com',
      'bio':
          'Analista financeiro apaixonado por números e otimização de processos.',
      'birthDate': '27-07-1991',
      'occupation': 'Analista Financeiro',
      'company': 'Eurofarma',
      'position': 'Analista Financeiro',
      'linkedin': 'https://www.linkedin.com/in/rafaelmartins',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Ciências Contábeis',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Finanças Corporativas, Contabilidade, Gestão de Riscos',
      'personalityType': 'INTJ',
    });

    await db.insert('profiles', {
      'userId': 9,
      'name': 'Fernanda Machado',
      'certificateName': 'Fernanda Machado',
      'email': 'fernanda.machado@eurofarma.com',
      'bio':
          'Especialista em Relações Públicas com foco em responsabilidade social.',
      'birthDate': '03-02-1985',
      'occupation': 'Especialista em Relações Públicas',
      'company': 'Eurofarma',
      'position': 'Gerente de Relações Públicas',
      'linkedin': 'https://www.linkedin.com/in/fernandamachado',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Comunicação Social',
      'institution': 'Universidade Federal de Minas Gerais',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Responsabilidade Social, Comunicação Corporativa, Sustentabilidade',
      'personalityType': 'ENFP',
    });

    await db.insert('profiles', {
      'userId': 10,
      'name': 'Roberto Costa',
      'certificateName': 'Roberto Costa',
      'email': 'roberto.costa@eurofarma.com',
      'bio':
          'Gestor de qualidade com experiência em grandes indústrias farmacêuticas.',
      'birthDate': '18-04-1979',
      'occupation': 'Gestor de Qualidade',
      'company': 'Eurofarma',
      'position': 'Gerente de Qualidade',
      'linkedin': 'https://www.linkedin.com/in/robertocosta',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia Química',
      'institution': 'Universidade Estadual de Campinas',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests': 'Controle de Qualidade, Processos Industriais, Auditorias',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 11,
      'name': 'Juliana Melo',
      'certificateName': 'Juliana Melo',
      'email': 'juliana.melo@eurofarma.com',
      'bio': 'Especialista em treinamento e desenvolvimento organizacional.',
      'birthDate': '30-06-1993',
      'occupation': 'Especialista em Treinamento e Desenvolvimento',
      'company': 'Eurofarma',
      'position': 'Gerente de Treinamento e Desenvolvimento',
      'linkedin': 'https://www.linkedin.com/in/julianamelo',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Psicologia Organizacional',
      'institution': 'Universidade Estadual do Rio de Janeiro',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Treinamento, Desenvolvimento Pessoal, Gestão de Talentos',
      'personalityType': 'ESFJ',
    });

    await db.insert('profiles', {
      'userId': 12,
      'name': 'Antonio Ramos',
      'certificateName': 'Antonio Ramos',
      'email': 'antonio.ramos@eurofarma.com',
      'bio': 'Auditor especializado em conformidade e análise de riscos.',
      'birthDate': '11-08-1984',
      'occupation': 'Auditor',
      'company': 'Eurofarma',
      'position': 'Auditor Sênior',
      'linkedin': 'https://www.linkedin.com/in/antonioramos',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Contabilidade',
      'institution': 'Pontifícia Universidade Católica',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Auditoria, Conformidade, Análise de Riscos',
      'personalityType': 'ISTP',
    });

    await db.insert('profiles', {
      'userId': 13,
      'name': 'Camila Silveira',
      'certificateName': 'Camila Silveira',
      'email': 'camila.silveira@eurofarma.com',
      'bio':
          'Gestora de recursos humanos com foco em desenvolvimento de lideranças.',
      'birthDate': '21-02-1987',
      'occupation': 'Gestora de Recursos Humanos',
      'company': 'Eurofarma',
      'position': 'Gerente de RH',
      'linkedin': 'https://www.linkedin.com/in/camilasilveira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Gestão de Recursos Humanos',
      'institution': 'Universidade Anhembi Morumbi',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests':
          'Desenvolvimento de Lideranças, Gestão de Talentos, Cultura Organizacional',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 14,
      'name': 'Eduardo Lima',
      'certificateName': 'Eduardo Lima',
      'email': 'eduardo.lima@eurofarma.com',
      'bio':
          'Especialista em vendas internacionais, com vasta experiência no mercado latino-americano.',
      'birthDate': '13-10-1982',
      'occupation': 'Especialista em Vendas Internacionais',
      'company': 'Eurofarma',
      'position': 'Gerente de Vendas Internacionais',
      'linkedin': 'https://www.linkedin.com/in/eduardolima',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração de Empresas',
      'institution': 'Universidade Federal de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Vendas, Negócios Internacionais, Mercado Latino-Americano',
      'personalityType': 'ENTP',
    });

    await db.insert('profiles', {
      'userId': 15,
      'name': 'Roberta Nogueira',
      'certificateName': 'Roberta Nogueira',
      'email': 'roberta.nogueira@eurofarma.com',
      'bio':
          'Engenheira de produção com experiência em otimização de processos industriais.',
      'birthDate': '29-03-1990',
      'occupation': 'Engenheira de Produção',
      'company': 'Eurofarma',
      'position': 'Gerente de Produção',
      'linkedin': 'https://www.linkedin.com/in/robertanogueira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia de Produção',
      'institution': 'Instituto Mauá de Tecnologia',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Otimização de Processos, Manufatura, Engenharia de Produção',
      'personalityType': 'INTJ',
    });

    await db.insert('profiles', {
      'userId': 16,
      'name': 'Daniel Barros',
      'certificateName': 'Daniel Barros',
      'email': 'daniel.barros@eurofarma.com',
      'bio':
          'Especialista em TI com foco em segurança da informação e proteção de dados.',
      'birthDate': '12-11-1992',
      'occupation': 'Especialista em TI',
      'company': 'Eurofarma',
      'position': 'Gerente de Segurança da Informação',
      'linkedin': 'https://www.linkedin.com/in/danielbarros',
      'twitter': '',
      'github': 'https://github.com/danielbarros',
      'customLink': '',
      'course': 'Segurança da Informação',
      'institution': 'Universidade Presbiteriana Mackenzie',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Segurança da Informação, Proteção de Dados, TI',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 17,
      'name': 'Aline Santos',
      'certificateName': 'Aline Santos',
      'email': 'aline.santos@eurofarma.com',
      'bio':
          'Gerente de marketing digital com ampla experiência em campanhas online.',
      'birthDate': '07-01-1989',
      'occupation': 'Gerente de Marketing Digital',
      'company': 'Eurofarma',
      'position': 'Gerente de Marketing',
      'linkedin': 'https://www.linkedin.com/in/alinesantos',
      'twitter': 'https://twitter.com/alinesantos',
      'github': '',
      'customLink': '',
      'course': 'Marketing',
      'institution': 'Universidade de São Paulo',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Marketing Digital, E-commerce, Publicidade Online',
      'personalityType': 'ESFP',
    });

    await db.insert('profiles', {
      'userId': 18,
      'name': 'Mario Andrade',
      'certificateName': 'Mario Andrade',
      'email': 'mario.andrade@eurofarma.com',
      'bio':
          'Consultor de inovação com foco em novas tecnologias para a área farmacêutica.',
      'birthDate': '25-09-1986',
      'occupation': 'Consultor de Inovação',
      'company': 'Eurofarma',
      'position': 'Consultor Sênior',
      'linkedin': 'https://www.linkedin.com/in/marioandrade',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Inovação e Tecnologia',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests': 'Inovação, Tecnologia, Pesquisa e Desenvolvimento',
      'personalityType': 'ENTP',
    });

    await db.insert('profiles', {
      'userId': 19,
      'name': 'Bruna Lopes',
      'certificateName': 'Bruna Lopes',
      'email': 'bruna.lopes@eurofarma.com',
      'bio': 'Especialista em gestão de crises e comunicação corporativa.',
      'birthDate': '14-05-1991',
      'occupation': 'Gerente de Comunicação',
      'company': 'Eurofarma',
      'position': 'Gerente de Comunicação Corporativa',
      'linkedin': 'https://www.linkedin.com/in/brunalopes',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Comunicação Social',
      'institution': 'Universidade Federal do Rio de Janeiro',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Gestão de Crises, Comunicação, Relações Públicas',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 20,
      'name': 'Henrique Teixeira',
      'certificateName': 'Henrique Teixeira',
      'email': 'henrique.teixeira@eurofarma.com',
      'bio':
          'Consultor de engenharia com vasta experiência em projetos industriais.',
      'birthDate': '23-07-1985',
      'occupation': 'Consultor de Engenharia',
      'company': 'Eurofarma',
      'position': 'Consultor Sênior',
      'linkedin': 'https://www.linkedin.com/in/henriqueteixeira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia Mecânica',
      'institution': 'Universidade Estadual de Campinas',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Engenharia Industrial, Manufatura, Qualidade',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 21,
      'name': 'Ana Moura',
      'certificateName': 'Ana Moura',
      'email': 'ana.moura@eurofarma.com',
      'bio':
          'Analista de logística com foco em otimização de cadeia de suprimentos.',
      'birthDate': '05-02-1989',
      'occupation': 'Analista de Logística',
      'company': 'Eurofarma',
      'position': 'Supervisora de Logística',
      'linkedin': 'https://www.linkedin.com/in/anamoura',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Logística',
      'institution': 'Universidade de Santo Amaro',
      'educationType': 'Tecnólogo',
      'isCompleted': 1,
      'interests': 'Logística, Cadeia de Suprimentos, Gestão de Ativos',
      'personalityType': 'ESTJ',
    });

    await db.insert('profiles', {
      'userId': 22,
      'name': 'Vinicius Gomes',
      'certificateName': 'Vinicius Gomes',
      'email': 'vinicius.gomes@eurofarma.com',
      'bio':
          'Desenvolvedor com vasta experiência em soluções web e sistemas corporativos.',
      'birthDate': '20-09-1992',
      'occupation': 'Desenvolvedor Full Stack',
      'company': 'Eurofarma',
      'position': 'Analista de Sistemas',
      'linkedin': 'https://www.linkedin.com/in/viniciusgomes',
      'twitter': 'https://twitter.com/viniciusgomes',
      'github': 'https://github.com/viniciusgomes',
      'customLink': '',
      'course': 'Sistemas de Informação',
      'institution': 'Universidade Federal de Minas Gerais',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Programação, Desenvolvimento Web, Soluções Corporativas',
      'personalityType': 'INTP',
    });

    await db.insert('profiles', {
      'userId': 23,
      'name': 'Carla Monteiro',
      'certificateName': 'Carla Monteiro',
      'email': 'carla.monteiro@eurofarma.com',
      'bio':
          'Especialista em saúde e segurança no trabalho com foco em ambientes industriais.',
      'birthDate': '30-11-1983',
      'occupation': 'Engenheira de Segurança do Trabalho',
      'company': 'Eurofarma',
      'position': 'Supervisora de Saúde e Segurança',
      'linkedin': 'https://www.linkedin.com/in/carlamonteiro',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia de Segurança do Trabalho',
      'institution': 'Universidade Paulista',
      'educationType': 'Especialização',
      'isCompleted': 1,
      'interests':
          'Segurança do Trabalho, Saúde Ocupacional, Qualidade de Vida',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 24,
      'name': 'Guilherme Ribeiro',
      'certificateName': 'Guilherme Ribeiro',
      'email': 'guilherme.ribeiro@eurofarma.com',
      'bio':
          'Gestor de inovação com foco em pesquisa e desenvolvimento de novos produtos.',
      'birthDate': '14-06-1985',
      'occupation': 'Gestor de Inovação',
      'company': 'Eurofarma',
      'position': 'Diretor de P&D',
      'linkedin': 'https://www.linkedin.com/in/guilhermeribeiro',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração de Empresas',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Inovação, Pesquisa, Desenvolvimento de Produtos',
      'personalityType': 'ENTP',
    });

    await db.insert('profiles', {
      'userId': 25,
      'name': 'Nathalia Soares',
      'certificateName': 'Nathalia Soares',
      'email': 'nathalia.soares@eurofarma.com',
      'bio':
          'Analista financeira com experiência em gestão de ativos e controladoria.',
      'birthDate': '17-04-1993',
      'occupation': 'Analista Financeira',
      'company': 'Eurofarma',
      'position': 'Gerente de Controladoria',
      'linkedin': 'https://www.linkedin.com/in/nathaliasoares',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Finanças',
      'institution':
          'Faculdade de Economia, Administração e Contabilidade da USP',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Gestão de Ativos, Controladoria, Finanças Corporativas',
      'personalityType': 'ISTP',
    });

    await db.insert('profiles', {
      'userId': 26,
      'name': 'Diego Barbosa',
      'certificateName': 'Diego Barbosa',
      'email': 'diego.barbosa@eurofarma.com',
      'bio': 'Especialista em compras internacionais e gestão de fornecedores.',
      'birthDate': '28-08-1987',
      'occupation': 'Comprador Internacional',
      'company': 'Eurofarma',
      'position': 'Gerente de Compras',
      'linkedin': 'https://www.linkedin.com/in/diegobarbosa',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Comércio Exterior',
      'institution': 'Universidade Presbiteriana Mackenzie',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Gestão de Compras, Comércio Exterior, Relações com Fornecedores',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 27,
      'name': 'Vanessa Pinto',
      'certificateName': 'Vanessa Pinto',
      'email': 'vanessa.pinto@eurofarma.com',
      'bio':
          'Profissional de recursos humanos com foco em desenvolvimento de talentos.',
      'birthDate': '12-03-1990',
      'occupation': 'Gerente de Recursos Humanos',
      'company': 'Eurofarma',
      'position': 'Gerente de Desenvolvimento de Talentos',
      'linkedin': 'https://www.linkedin.com/in/vanessapinto',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Psicologia',
      'institution': 'Pontifícia Universidade Católica de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Desenvolvimento de Talentos, Recursos Humanos, Psicologia Organizacional',
      'personalityType': 'ESFJ',
    });

    await db.insert('profiles', {
      'userId': 28,
      'name': 'Leandro Campos',
      'certificateName': 'Leandro Campos',
      'email': 'leandro.campos@eurofarma.com',
      'bio':
          'Especialista em qualidade e conformidade, com foco em auditorias internas.',
      'birthDate': '05-12-1985',
      'occupation': 'Auditor Interno',
      'company': 'Eurofarma',
      'position': 'Supervisor de Auditoria',
      'linkedin': 'https://www.linkedin.com/in/leandrocampos',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests':
          'Qualidade, Conformidade, Auditoria Interna, Gestão de Riscos',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 29,
      'name': 'Priscila Rodrigues',
      'certificateName': 'Priscila Rodrigues',
      'email': 'priscila.rodrigues@eurofarma.com',
      'bio':
          'Consultora de marketing digital com foco em estratégias de e-commerce.',
      'birthDate': '17-10-1988',
      'occupation': 'Consultora de Marketing Digital',
      'company': 'Eurofarma',
      'position': 'Gerente de E-commerce',
      'linkedin': 'https://www.linkedin.com/in/priscilarodrigues',
      'twitter': 'https://twitter.com/priscilarodrigues',
      'github': '',
      'customLink': '',
      'course': 'Marketing',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Marketing Digital, E-commerce, Gestão de Produtos',
      'personalityType': 'ENTP',
    });

    await db.insert('profiles', {
      'userId': 30,
      'name': 'Marcos Batista',
      'certificateName': 'Marcos Batista',
      'email': 'marcos.batista@eurofarma.com',
      'bio': 'Profissional de TI especializado em segurança da informação.',
      'birthDate': '22-04-1990',
      'occupation': 'Analista de Segurança da Informação',
      'company': 'Eurofarma',
      'position': 'Coordenador de Segurança da Informação',
      'linkedin': 'https://www.linkedin.com/in/marcosbatista',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Segurança da Informação',
      'institution': 'FIAP',
      'educationType': 'Pós-graduação',
      'isCompleted': 1,
      'interests': 'Segurança da Informação, TI, Gestão de Riscos Cibernéticos',
      'personalityType': 'ISTP',
    });

    await db.insert('profiles', {
      'userId': 31,
      'name': 'Diana Almeida',
      'certificateName': 'Diana Almeida',
      'email': 'diana.almeida@eurofarma.com',
      'bio':
          'Especialista em sustentabilidade e práticas ambientais no setor industrial.',
      'birthDate': '11-07-1986',
      'occupation': 'Consultora de Sustentabilidade',
      'company': 'Eurofarma',
      'position': 'Gerente de Sustentabilidade',
      'linkedin': 'https://www.linkedin.com/in/dianaalmeida',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia Ambiental',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Sustentabilidade, Meio Ambiente, Gestão de Resíduos',
      'personalityType': 'INFJ',
    });

    await db.insert('profiles', {
      'userId': 32,
      'name': 'Felipe Carvalho',
      'certificateName': 'Felipe Carvalho',
      'email': 'felipe.carvalho@eurofarma.com',
      'bio': 'Especialista em gestão de crises e comunicação corporativa.',
      'birthDate': '08-11-1984',
      'occupation': 'Gestor de Crises',
      'company': 'Eurofarma',
      'position': 'Gerente de Crises Corporativas',
      'linkedin': 'https://www.linkedin.com/in/felipecarvalho',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests':
          'Gestão de Crises, Comunicação Corporativa, Relações Públicas',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 33,
      'name': 'Thais Miranda',
      'certificateName': 'Thais Miranda',
      'email': 'thais.miranda@eurofarma.com',
      'bio':
          'Especialista em responsabilidade social e programas de diversidade.',
      'birthDate': '15-05-1991',
      'occupation': 'Consultora de Diversidade',
      'company': 'Eurofarma',
      'position': 'Gerente de Diversidade e Inclusão',
      'linkedin': 'https://www.linkedin.com/in/thaismiranda',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Sociologia',
      'institution': 'Universidade Estadual de Campinas',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests': 'Diversidade, Inclusão, Responsabilidade Social, Sociologia',
      'personalityType': 'ENFP',
    });

    await db.insert('profiles', {
      'userId': 34,
      'name': 'Rodrigo Moreira',
      'certificateName': 'Rodrigo Moreira',
      'email': 'rodrigo.moreira@eurofarma.com',
      'bio':
          'Engenheiro de projetos com experiência em gestão de infraestrutura.',
      'birthDate': '18-01-1989',
      'occupation': 'Engenheiro de Projetos',
      'company': 'Eurofarma',
      'position': 'Coordenador de Infraestrutura',
      'linkedin': 'https://www.linkedin.com/in/rodrigomoreira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia Civil',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Infraestrutura, Engenharia, Gestão de Projetos',
      'personalityType': 'ISTP',
    });

    await db.insert('profiles', {
      'userId': 35,
      'name': 'Luciana Freitas',
      'certificateName': 'Luciana Freitas',
      'email': 'luciana.freitas@eurofarma.com',
      'bio':
          'Profissional com ampla experiência em gestão de projetos farmacêuticos.',
      'birthDate': '12-09-1985',
      'occupation': 'Gestora de Projetos',
      'company': 'Eurofarma',
      'position': 'Gerente de Projetos Farmacêuticos',
      'linkedin': 'https://www.linkedin.com/in/lucianafreitas',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Farmácia',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests': 'Gestão de Projetos, Desenvolvimento de Produtos, Farmácia',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 36,
      'name': 'Bruno Dias',
      'certificateName': 'Bruno Dias',
      'email': 'bruno.dias@eurofarma.com',
      'bio':
          'Especialista em inovação e desenvolvimento de novos medicamentos.',
      'birthDate': '04-05-1987',
      'occupation': 'Pesquisador de Inovação',
      'company': 'Eurofarma',
      'position': 'Gerente de Inovação e Pesquisa',
      'linkedin': 'https://www.linkedin.com/in/brunodias',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Biotecnologia',
      'institution': 'Universidade Estadual de Campinas',
      'educationType': 'Doutorado',
      'isCompleted': 1,
      'interests': 'Inovação, Desenvolvimento de Medicamentos, Biotecnologia',
      'personalityType': 'INTP',
    });

    await db.insert('profiles', {
      'userId': 37,
      'name': 'Leticia Castro',
      'certificateName': 'Leticia Castro',
      'email': 'leticia.castro@eurofarma.com',
      'bio':
          'Líder em planejamento estratégico com foco em expansão de mercado.',
      'birthDate': '27-03-1992',
      'occupation': 'Consultora de Planejamento Estratégico',
      'company': 'Eurofarma',
      'position': 'Gerente de Planejamento Estratégico',
      'linkedin': 'https://www.linkedin.com/in/leticiacastro',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests':
          'Planejamento Estratégico, Expansão de Mercado, Gestão de Negócios',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 38,
      'name': 'Anderson Oliveira',
      'certificateName': 'Anderson Oliveira',
      'email': 'anderson.oliveira@eurofarma.com',
      'bio': 'Especialista em análise de dados e inteligência de mercado.',
      'birthDate': '21-06-1990',
      'occupation': 'Analista de Inteligência de Mercado',
      'company': 'Eurofarma',
      'position': 'Gerente de Inteligência de Mercado',
      'linkedin': 'https://www.linkedin.com/in/andersonoliveira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia de Produção',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Análise de Dados, Inteligência de Mercado, Gestão de Ativos',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 39,
      'name': 'Sabrina Reis',
      'certificateName': 'Sabrina Reis',
      'email': 'sabrina.reis@eurofarma.com',
      'bio': 'Profissional de marketing digital com experiência em e-commerce.',
      'birthDate': '05-11-1993',
      'occupation': 'Especialista em Marketing Digital',
      'company': 'Eurofarma',
      'position': 'Coordenadora de E-commerce',
      'linkedin': 'https://www.linkedin.com/in/sabrinareis',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Marketing',
      'institution': 'Universidade Anhembi Morumbi',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Marketing Digital, E-commerce, Redes Sociais',
      'personalityType': 'ENFP',
    });

    await db.insert('profiles', {
      'userId': 40,
      'name': 'Gilberto Fonseca',
      'certificateName': 'Gilberto Fonseca',
      'email': 'gilberto.fonseca@eurofarma.com',
      'bio': 'Especialista em auditoria interna com foco em gestão de riscos.',
      'birthDate': '16-08-1982',
      'occupation': 'Auditor Interno',
      'company': 'Eurofarma',
      'position': 'Gerente de Auditoria e Gestão de Riscos',
      'linkedin': 'https://www.linkedin.com/in/gilbertofonseca',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Auditoria, Gestão de Riscos, Conformidade',
      'personalityType': 'ISTJ',
    });

    await db.insert('profiles', {
      'userId': 41,
      'name': 'Raquel Pires',
      'certificateName': 'Raquel Pires',
      'email': 'raquel.pires@eurofarma.com',
      'bio': 'Especialista em gestão de contratos e compliance empresarial.',
      'birthDate': '09-02-1989',
      'occupation': 'Gestora de Contratos',
      'company': 'Eurofarma',
      'position': 'Coordenadora de Compliance',
      'linkedin': 'https://www.linkedin.com/in/raquelpires',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Direito',
      'institution': 'Pontifícia Universidade Católica de São Paulo',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests': 'Gestão de Contratos, Compliance, Direito Empresarial',
      'personalityType': 'INTJ',
    });

    await db.insert('profiles', {
      'userId': 42,
      'name': 'Fabio Martinez',
      'certificateName': 'Fabio Martinez',
      'email': 'fabio.martinez@eurofarma.com',
      'bio': 'Especialista em gestão de riscos corporativos e governança.',
      'birthDate': '15-04-1984',
      'occupation': 'Consultor de Riscos Corporativos',
      'company': 'Eurofarma',
      'position': 'Gerente de Governança e Riscos',
      'linkedin': 'https://www.linkedin.com/in/fabiomartinez',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Administração',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Governança, Gestão de Riscos, Conformidade',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 43,
      'name': 'Andrea Martins',
      'certificateName': 'Andrea Martins',
      'email': 'andrea.martins@eurofarma.com',
      'bio': 'Especialista em responsabilidade social e sustentabilidade.',
      'birthDate': '22-07-1985',
      'occupation': 'Consultora de Sustentabilidade',
      'company': 'Eurofarma',
      'position': 'Coordenadora de Sustentabilidade',
      'linkedin': 'https://www.linkedin.com/in/andreamartins',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia Ambiental',
      'institution': 'Universidade Federal de São Carlos',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Sustentabilidade, Responsabilidade Social, Meio Ambiente',
      'personalityType': 'INFJ',
    });

    await db.insert('profiles', {
      'userId': 44,
      'name': 'Gustavo Lima',
      'certificateName': 'Gustavo Lima',
      'email': 'gustavo.lima@eurofarma.com',
      'bio': 'Especialista em logística e distribuição internacional.',
      'birthDate': '03-03-1986',
      'occupation': 'Coordenador de Logística',
      'company': 'Eurofarma',
      'position': 'Gerente de Logística e Distribuição',
      'linkedin': 'https://www.linkedin.com/in/gustavolima',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Engenharia de Produção',
      'institution': 'Universidade Federal do Rio de Janeiro',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Logística, Distribuição, Gestão de Operações',
      'personalityType': 'ESTJ',
    });

    await db.insert('profiles', {
      'userId': 45,
      'name': 'Laura Silva',
      'certificateName': 'Laura Silva',
      'email': 'laura.silva@eurofarma.com',
      'bio':
          'Gerente de treinamento e desenvolvimento com foco em liderança organizacional.',
      'birthDate': '18-05-1991',
      'occupation': 'Gerente de Treinamento',
      'company': 'Eurofarma',
      'position': 'Gerente de Treinamento e Desenvolvimento',
      'linkedin': 'https://www.linkedin.com/in/laurasilva',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Psicologia Organizacional',
      'institution': 'Universidade Estadual de Campinas',
      'educationType': 'Mestrado',
      'isCompleted': 1,
      'interests':
          'Desenvolvimento de Lideranças, Capacitação, Psicologia Organizacional',
      'personalityType': 'ENFJ',
    });

    await db.insert('profiles', {
      'userId': 46,
      'name': 'Paulo Vieira',
      'certificateName': 'Paulo Vieira',
      'email': 'paulo.vieira@eurofarma.com',
      'bio':
          'Profissional com vasta experiência em segurança da informação e proteção de dados.',
      'birthDate': '30-01-1978',
      'occupation': 'Consultor de Segurança da Informação',
      'company': 'Eurofarma',
      'position': 'Gerente de Segurança da Informação',
      'linkedin': 'https://www.linkedin.com/in/paulovieira',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Segurança da Informação',
      'institution': 'Universidade Federal do Paraná',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Segurança da Informação, Proteção de Dados, Gestão de Riscos',
      'personalityType': 'ISTP',
    });

    await db.insert('profiles', {
      'userId': 47,
      'name': 'Cristina Araujo',
      'certificateName': 'Cristina Araujo',
      'email': 'cristina.araujo@eurofarma.com',
      'bio':
          'Especialista em finanças corporativas com foco em auditoria interna.',
      'birthDate': '12-07-1983',
      'occupation': 'Consultora Financeira',
      'company': 'Eurofarma',
      'position': 'Gerente de Finanças Corporativas',
      'linkedin': 'https://www.linkedin.com/in/cristinaaraujo',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Ciências Contábeis',
      'institution': 'Fundação Getúlio Vargas',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests': 'Auditoria Interna, Finanças Corporativas, Gestão de Ativos',
      'personalityType': 'ENTJ',
    });

    await db.insert('profiles', {
      'userId': 48,
      'name': 'Tiago Ribeiro',
      'certificateName': 'Tiago Ribeiro',
      'email': 'tiago.ribeiro@eurofarma.com',
      'bio': 'Especialista em desenvolvimento de produtos farmacêuticos.',
      'birthDate': '22-11-1984',
      'occupation': 'Desenvolvedor de Produtos',
      'company': 'Eurofarma',
      'position': 'Gerente de Desenvolvimento de Produtos',
      'linkedin': 'https://www.linkedin.com/in/tiagoribeiro',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Farmácia',
      'institution': 'Universidade de São Paulo',
      'educationType': 'Doutorado',
      'isCompleted': 1,
      'interests':
          'Desenvolvimento de Produtos, Pesquisa Farmacêutica, Qualidade',
      'personalityType': 'INFJ',
    });

    await db.insert('profiles', {
      'userId': 49,
      'name': 'Luana Torres',
      'certificateName': 'Luana Torres',
      'email': 'luana.torres@eurofarma.com',
      'bio':
          'Gerente de vendas internacionais com experiência em negociação global.',
      'birthDate': '09-10-1986',
      'occupation': 'Gerente de Vendas Internacionais',
      'company': 'Eurofarma',
      'position': 'Diretora de Vendas Internacionais',
      'linkedin': 'https://www.linkedin.com/in/luanatorres',
      'twitter': '',
      'github': '',
      'customLink': '',
      'course': 'Relações Internacionais',
      'institution': 'Universidade de Brasília',
      'educationType': 'MBA',
      'isCompleted': 1,
      'interests':
          'Negociação Global, Vendas Internacionais, Expansão de Mercado',
      'personalityType': 'ESTJ',
    });

    await db.insert('profiles', {
      'userId': 50,
      'name': 'Rafael Fiel',
      'certificateName': 'Rafael Fiel',
      'email': 'rafael.fiel@eurofarma.com',
      'bio':
          'Estudante de Sistemas de Informação na FIAP e Estagiário de Gestão de Projetos',
      'birthDate': '24-09-2001',
      'occupation': 'Estagiário de Gestão de Projetos',
      'company': 'Eurofarma',
      'position': 'Estagiário de Gestão de Projetos',
      'linkedin': 'https://www.linkedin.com/in/rafaelfcm/',
      'twitter': '',
      'github': 'https://github.com/RafaelFCM',
      'customLink': '',
      'course': 'Sistemas de Informação',
      'institution': 'Faculdade de Informática e Administração Paulista',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests':
          'Excel - VBA, Java, Flutter, Angular, SQL, Agile, Power BI',
      'personalityType': 'ESTJ',
    });

    // Insert inicial para tópicos de materias
    await db.insert('topics', {'name': 'Programação'});
    await db.insert('topics', {'name': 'Front-end'});
    await db.insert('topics', {'name': 'Data Science'});
    await db.insert('topics', {'name': 'Inteligência Artifical'});
    await db.insert('topics', {'name': 'Design'});
    await db.insert('topics', {'name': 'Gestão'});
    await db.insert('topics', {'name': 'Office 365'});
    await db.insert('topics', {'name': 'Power Platforms'});
    await db.insert('topics', {'name': 'Desenvolvimento Pessoal'});
    await db.insert('topics', {'name': 'Inteligência Emocional'});
    await db.insert('topics', {'name': 'Comunicação Corporativa'});
    await db.insert('topics', {'name': 'Vendas e Negociação'});
    await db.insert('topics', {'name': 'Liderança e Gestão de Equipes'});
    await db.insert('topics', {'name': 'Saúde e Segurança no Trabalho'});
    await db.insert('topics', {'name': 'Sustentabilidade Empresarial'});
    await db.insert('topics', {'name': 'Auditoria e Compliance'});
    await db.insert('topics', {'name': 'Marketing Digital'});
    await db.insert('topics', {'name': 'Inovação e Criatividade'});
    await db.insert('topics', {'name': 'Ética Empresarial'});
    await db.insert('topics', {'name': 'Segurança da Informação'});
    await db.insert('topics', {'name': 'Atendimento ao Cliente'});
    await db.insert('topics', {'name': 'Planejamento Estratégico'});
    await db.insert('topics', {'name': 'Desenvolvimento de Negócios'});
    await db.insert('topics', {'name': 'Gestão de Facilities'});

    // Insert inicial dos cursos
    await db.insert('courses', {
      'courseId': 1,
      'title': 'Flutter',
      'description': 'Aprenda Flutter do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_flutter.jpg',
      'instructors': 'Professor Carlos A., Professor José F.',
      'duration': '80h',
      'topicId': 1, // Programação
    });

    await db.insert('courses', {
      'courseId': 2,
      'title': 'Java',
      'description': 'Aprenda Java do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_java.jpg',
      'instructors': 'Professor Carlos A., Professor Pedro M.',
      'duration': '80h',
      'topicId': 1, // Programação
    });

    await db.insert('courses', {
      'courseId': 3,
      'title': 'Python para Iniciantes',
      'description': 'Introdução à programação em Python.',
      'imageUrl': 'assets/images/capa_python.jpg',
      'instructors': 'Professor Laura M.',
      'duration': '40h',
      'topicId': 1,
    });

    await db.insert('courses', {
      'courseId': 4,
      'title': 'C# Essencial',
      'description': 'Domine o C# para desenvolvimento de software.',
      'imageUrl': 'assets/images/capa_csharp.jpg',
      'instructors': 'Professor Marcos L.',
      'duration': '50h',
      'topicId': 1,
    });

    await db.insert('courses', {
      'courseId': 5,
      'title': 'JavaScript para Web',
      'description': 'Tudo sobre JavaScript para desenvolvimento web.',
      'imageUrl': 'assets/images/capa_js.jpg',
      'instructors': 'Professor Alice P.',
      'duration': '45h',
      'topicId': 1,
    });

    await db.insert('courses', {
      'courseId': 6,
      'title': 'React',
      'description': 'Aprenda React do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_react.jpg',
      'instructors': 'Professor Felipe P., Professora Helena M.',
      'duration': '35h',
      'topicId': 2, // Front-end
    });

    await db.insert('courses', {
      'courseId': 7,
      'title': 'HTML e CSS',
      'description': 'Criação de páginas web com HTML e CSS.',
      'imageUrl': 'assets/images/capa_html_css.jpg',
      'instructors': 'Professor Eduardo M.',
      'duration': '30h',
      'topicId': 2,
    });

    await db.insert('courses', {
      'courseId': 8,
      'title': 'Vue.js do Zero',
      'description': 'Aprenda Vue.js e crie aplicações dinâmicas.',
      'imageUrl': 'assets/images/capa_vue.jpg',
      'instructors': 'Professor João B.',
      'duration': '35h',
      'topicId': 2,
    });

    await db.insert('courses', {
      'courseId': 9,
      'title': 'Desenvolvimento com Angular',
      'description': 'Fundamentos e projetos com Angular.',
      'imageUrl': 'assets/images/capa_angular.jpg',
      'instructors': 'Professor Larissa A.',
      'duration': '50h',
      'topicId': 2,
    });

    await db.insert('courses', {
      'courseId': 10,
      'title': 'Web Design Responsivo',
      'description': 'Técnicas de design responsivo para sites modernos.',
      'imageUrl': 'assets/images/capa_responsive_design.jpg',
      'instructors': 'Professor Ricardo V.',
      'duration': '25h',
      'topicId': 2,
    });

    await db.insert('courses', {
      'courseId': 11,
      'title': 'Introdução ao Data Science',
      'description': 'Os fundamentos da ciência de dados.',
      'imageUrl': 'assets/images/capa_data_science.jpg',
      'instructors': 'Professor Carlos N.',
      'duration': '60h',
      'topicId': 3,
    });

    await db.insert('courses', {
      'courseId': 12,
      'title': 'Python para Data Science',
      'description': 'Utilize Python para análise de dados.',
      'imageUrl': 'assets/images/capa_python_ds.jpg',
      'instructors': 'Professor Gabriela R.',
      'duration': '45h',
      'topicId': 3,
    });

    await db.insert('courses', {
      'courseId': 13,
      'title': 'Análise Estatística',
      'description':
          'Domine as técnicas de análise estatística com dados reais.',
      'imageUrl': 'assets/images/capa_estatistica.jpg',
      'instructors': 'Professor Rodrigo M.',
      'duration': '40h',
      'topicId': 3,
    });

    await db.insert('courses', {
      'courseId': 14,
      'title': 'Machine Learning',
      'description': 'Conceitos e aplicações de Machine Learning.',
      'imageUrl': 'assets/images/capa_ml.jpg',
      'instructors': 'Professor Débora F.',
      'duration': '70h',
      'topicId': 3,
    });

    await db.insert('courses', {
      'courseId': 15,
      'title': 'Big Data',
      'description': 'Entenda como trabalhar com Big Data e suas tecnologias.',
      'imageUrl': 'assets/images/capa_big_data.jpg',
      'instructors': 'Professor Thiago C.',
      'duration': '55h',
      'topicId': 3,
    });

    await db.insert('courses', {
      'courseId': 16,
      'title': 'Fundamentos de Inteligência Artificial',
      'description': 'Entenda o que é e como funciona a IA.',
      'imageUrl': 'assets/images/capa_ia.jpg',
      'instructors': 'Professor Paulo R.',
      'duration': '60h',
      'topicId': 4,
    });

    await db.insert('courses', {
      'courseId': 17,
      'title': 'Redes Neurais',
      'description': 'Aplicações e desenvolvimento de redes neurais.',
      'imageUrl': 'assets/images/capa_neural_networks.jpg',
      'instructors': 'Professor Elisa S.',
      'duration': '80h',
      'topicId': 4,
    });

    await db.insert('courses', {
      'courseId': 18,
      'title': 'Processamento de Linguagem Natural',
      'description': 'Como ensinar computadores a entender linguagem humana.',
      'imageUrl': 'assets/images/capa_nlp.jpg',
      'instructors': 'Professor Eduardo G.',
      'duration': '70h',
      'topicId': 4,
    });

    await db.insert('courses', {
      'courseId': 19,
      'title': 'Visão Computacional',
      'description': 'Desenvolvimento de sistemas com Visão Computacional.',
      'imageUrl': 'assets/images/capa_vision.jpg',
      'instructors': 'Professor Sabrina L.',
      'duration': '65h',
      'topicId': 4,
    });

    await db.insert('courses', {
      'courseId': 20,
      'title': 'Deep Learning Avançado',
      'description': 'Técnicas avançadas de deep learning para IA.',
      'imageUrl': 'assets/images/capa_deep_learning.jpg',
      'instructors': 'Professor Rafael D.',
      'duration': '90h',
      'topicId': 4,
    });

    await db.insert('courses', {
      'courseId': 21,
      'title': 'Fundamentos de Design Gráfico',
      'description': 'Introdução ao design gráfico para iniciantes.',
      'imageUrl': 'assets/images/capa_design.jpg',
      'instructors': 'Professor Lucas T.',
      'duration': '40h',
      'topicId': 5,
    });

    await db.insert('courses', {
      'courseId': 22,
      'title': 'UX e UI Design',
      'description': 'Técnicas de design focadas na experiência do usuário.',
      'imageUrl': 'assets/images/capa_ux_ui.jpg',
      'instructors': 'Professor Mariana D.',
      'duration': '35h',
      'topicId': 5,
    });

    await db.insert('courses', {
      'courseId': 23,
      'title': 'Adobe Photoshop Completo',
      'description': 'Curso prático de Adobe Photoshop para designers.',
      'imageUrl': 'assets/images/capa_photoshop.jpg',
      'instructors': 'Professor André F.',
      'duration': '30h',
      'topicId': 5,
    });

    await db.insert('courses', {
      'courseId': 24,
      'title': 'Adobe Illustrator do Zero',
      'description': 'Domine o Adobe Illustrator para criação de vetores.',
      'imageUrl': 'assets/images/capa_illustrator.jpg',
      'instructors': 'Professor Camila V.',
      'duration': '45h',
        'topicId': 5,
    });

    await db.insert('courses', {
      'courseId': 25,
      'title': 'Design para Mídias Sociais',
      'description': 'Criação de designs impactantes para redes sociais.',
      'imageUrl': 'assets/images/capa_design_midia.jpg',
      'instructors': 'Professor Pedro R.',
      'duration': '25h',
      'topicId': 5,
    });

    await db.insert('courses', {
      'courseId': 26,
      'title': 'Gestão de Projetos',
      'description': 'Fundamentos e práticas de gerenciamento de projetos.',
      'imageUrl': 'assets/images/capa_gestao_projetos.jpg',
      'instructors': 'Professor Gustavo F.',
      'duration': '50h',
      'topicId': 6,
    });

    await db.insert('courses', {
      'courseId': 27,
      'title': 'Gestão de Equipes',
      'description': 'Aprenda a liderar e gerir equipes com eficiência.',
      'imageUrl': 'assets/images/capa_gestao_equipes.jpg',
      'instructors': 'Professor Fernanda M.',
      'duration': '40h',
      'topicId': 6,
    });

    await db.insert('courses', {
      'courseId': 28,
      'title': 'Planejamento Estratégico',
      'description': 'Desenvolvimento e execução de estratégias empresariais.',
      'imageUrl': 'assets/images/capa_planejamento_estrategico.jpg',
      'instructors': 'Professor Ricardo L.',
      'duration': '55h',
      'topicId': 6,
    });

    await db.insert('courses', {
      'courseId': 29,
      'title': 'Gestão de Processos',
      'description': 'Organize e melhore processos empresariais.',
      'imageUrl': 'assets/images/capa_gestao_processos.jpg',
      'instructors': 'Professor Laura A.',
      'duration': '45h',
      'topicId': 6,
    });

    await db.insert('courses', {
      'courseId': 30,
      'title': 'Gerenciamento de Tempo',
      'description': 'Domine a arte de gerenciar seu tempo de forma eficiente.',
      'imageUrl': 'assets/images/capa_gestao_tempo.jpg',
      'instructors': 'Professor Bruno S.',
      'duration': '30h',
      'topicId': 6,
    });

    await db.insert('courses', {
      'courseId': 31,
      'title': 'Introdução ao Office 365',
      'description': 'Domine as principais ferramentas do Office 365.',
      'imageUrl': 'assets/images/capa_office365.jpg',
      'instructors': 'Professor Daniel S.',
      'duration': '25h',
      'topicId': 7,
    });

    await db.insert('courses', {
      'courseId': 32,
      'title': 'Microsoft Excel Avançado',
      'description': 'Aprimore suas habilidades com Excel avançado.',
      'imageUrl': 'assets/images/capa_excel_avancado.jpg',
      'instructors': 'Professor Gabriela R.',
      'duration': '35h',
      'topicId': 7,
    });

    await db.insert('courses', {
      'courseId': 33,
      'title': 'Microsoft PowerPoint',
      'description': 'Criação de apresentações poderosas com PowerPoint.',
      'imageUrl': 'assets/images/capa_powerpoint.jpg',
      'instructors': 'Professor João B.',
      'duration': '20h',
      'topicId': 7,
    });

    await db.insert('courses', {
      'courseId': 34,
      'title': 'Microsoft Word Completo',
      'description': 'Domine as funcionalidades avançadas do Microsoft Word.',
      'imageUrl': 'assets/images/capa_word.jpg',
      'instructors': 'Professor Aline P.',
      'duration': '30h',
      'topicId': 7,
    });

    await db.insert('courses', {
      'courseId': 35,
      'title': 'Microsoft Teams para Empresas',
      'description':
          'Utilização do Microsoft Teams para comunicação corporativa.',
      'imageUrl': 'assets/images/capa_teams.jpg',
      'instructors': 'Professor Roberto C.',
      'duration': '20h',
      'topicId': 7,
    });

    await db.insert('courses', {
      'courseId': 36,
      'title': 'Introdução ao Power BI',
      'description': 'Transforme dados em insights com o Power BI.',
      'imageUrl': 'assets/images/capa_powerbi.jpg',
      'instructors': 'Professor Carolina D.',
      'duration': '45h',
      'topicId': 8,
    });

    await db.insert('courses', {
      'courseId': 37,
      'title': 'Automatizações com Power Automate',
      'description': 'Automatize processos com Power Automate.',
      'imageUrl': 'assets/images/capa_power_automate.jpg',
      'instructors': 'Professor André F.',
      'duration': '35h',
      'topicId': 8,
    });

    await db.insert('courses', {
      'courseId': 38,
      'title': 'Criação de Aplicativos com Power Apps',
      'description': 'Desenvolva aplicativos corporativos com Power Apps.',
      'imageUrl': 'assets/images/capa_power_apps.jpg',
      'instructors': 'Professor Lucas T.',
      'duration': '50h',
      'topicId': 8,
    });

    await db.insert('courses', {
      'courseId': 39,
      'title': 'Integração de Dados com Power BI e SQL',
      'description': 'Combine Power BI com SQL para análise de dados.',
      'imageUrl': 'assets/images/capa_powerbi_sql.jpg',
      'instructors': 'Professor Bruno V.',
      'duration': '40h',
      'topicId': 8,
    });

    await db.insert('courses', {
      'courseId': 40,
      'title': 'Dashboards Interativos com Power BI',
      'description': 'Crie dashboards dinâmicos e interativos com Power BI.',
      'imageUrl': 'assets/images/capa_dashboards.jpg',
      'instructors': 'Professor Felipe N.',
      'duration': '35h',
      'topicId': 8,
    });

    await db.insert('courses', {
      'courseId': 41,
      'title': 'Autodesenvolvimento e Carreira',
      'description':
          'Estratégias para melhorar suas habilidades profissionais.',
      'imageUrl': 'assets/images/capa_autodesenvolvimento.jpg',
      'instructors': 'Professor Mariana L.',
      'duration': '30h',
      'topicId': 9, // Desenvolvimento Pessoal
    });

    await db.insert('courses', {
      'courseId': 42,
      'title': 'Como ser líder',
      'description':
          'Aprenda do zero como desenvolver suas habilidades de liderança.',
      'imageUrl': 'assets/images/capa_curso_lideranca.jpg',
      'instructors': 'Professor Eduardo F.',
      'duration': '50h',
      'topicId': 9, 
    });

    await db.insert('courses', {
      'courseId': 42,
      'title': 'Resiliência e Adaptabilidade',
      'description': 'Desenvolva sua capacidade de resiliência e adaptação.',
      'imageUrl': 'assets/images/capa_resiliencia.jpg',
      'instructors': 'Professor João M.',
      'duration': '20h',
      'topicId': 9,
    });

    await db.insert('courses', {
      'courseId': 43,
      'title': 'Inteligência Emocional no Trabalho',
      'description':
          'Entenda como a inteligência emocional afeta o ambiente de trabalho.',
      'imageUrl': 'assets/images/capa_inteligencia_emocional.jpg',
      'instructors': 'Professor Renata S.',
      'duration': '25h',
      'topicId': 9,
    });

    await db.insert('courses', {
      'courseId': 44,
      'title': 'Planejamento de Carreira',
      'description':
          'Desenvolva um plano eficaz para a sua carreira profissional.',
      'imageUrl': 'assets/images/capa_planejamento_carreira.jpg',
      'instructors': 'Professor Fernanda C.',
      'duration': '35h',
      'topicId': 9,
    });

    await db.insert('courses', {
      'courseId': 46,
      'title': 'Controle de Emoções no Ambiente Corporativo',
      'description':
          'Aprenda a gerenciar suas emoções no ambiente de trabalho.',
      'imageUrl': 'assets/images/capa_controle_emocoes.jpg',
      'instructors': 'Professor Eduardo F.',
      'duration': '30h',
      'topicId': 10,
    });

    await db.insert('courses', {
      'courseId': 47,
      'title': 'Empatia e Relacionamento Interpessoal',
      'description':
          'Desenvolva habilidades de empatia no ambiente profissional.',
      'imageUrl': 'assets/images/capa_empatia.jpg',
      'instructors': 'Professor Priscila G.',
      'duration': '25h',
      'topicId': 10,
    });

    await db.insert('courses', {
      'courseId': 48,
      'title': 'Gestão de Conflitos com Inteligência Emocional',
      'description': 'Use a inteligência emocional para mediar conflitos.',
      'imageUrl': 'assets/images/capa_gestao_conflitos.jpg',
      'instructors': 'Professor Mário T.',
      'duration': '35h',
      'topicId': 10,
    });

    await db.insert('courses', {
      'courseId': 49,
      'title': 'Autoconsciência e Autogestão',
      'description':
          'Desenvolva a autoconsciência para melhorar sua performance.',
      'imageUrl': 'assets/images/capa_autoconsciencia.jpg',
      'instructors': 'Professor Fernanda L.',
      'duration': '20h',
      'topicId': 10,
    });

    await db.insert('courses', {
      'courseId': 50,
      'title': 'Inteligência Emocional para Líderes',
      'description':
          'Aprimore suas habilidades de liderança com inteligência emocional.',
      'imageUrl': 'assets/images/capa_lideranca_emocional.jpg',
      'instructors': 'Professor João P.',
      'duration': '40h',
      'topicId': 10,
    });

    await db.insert('courses', {
      'courseId': 51,
      'title': 'Comunicação Eficaz no Ambiente Corporativo',
      'description':
          'Melhore suas habilidades de comunicação no ambiente de trabalho.',
      'imageUrl': 'assets/images/capa_comunicacao_eficaz.jpg',
      'instructors': 'Professor Carlos R.',
      'duration': '30h',
      'topicId': 11,
    });

    await db.insert('courses', {
      'courseId': 52,
      'title': 'Técnicas de Apresentação Corporativa',
      'description': 'Aprenda técnicas para criar e apresentar com eficiência.',
      'imageUrl': 'assets/images/capa_apresentacao.jpg',
      'instructors': 'Professor Juliana A.',
      'duration': '25h',
      'topicId': 11,
    });

    await db.insert('courses', {
      'courseId': 53,
      'title': 'Redação Empresarial',
      'description':
          'Escreva com clareza e objetividade em contextos corporativos.',
      'imageUrl': 'assets/images/capa_redacao_empresarial.jpg',
      'instructors': 'Professor Roberto N.',
      'duration': '20h',
      'topicId': 11,
    });

    await db.insert('courses', {
      'courseId': 54,
      'title': 'Negociação e Comunicação Assertiva',
      'description':
          'Desenvolva habilidades de negociação com comunicação assertiva.',
      'imageUrl': 'assets/images/capa_negociacao.jpg',
      'instructors': 'Professor Larissa T.',
      'duration': '35h',
      'topicId': 11,
    });

    await db.insert('courses', {
      'courseId': 55,
      'title': 'Comunicação e Cultura Organizacional',
      'description':
          'Entenda a relação entre comunicação e cultura empresarial.',
      'imageUrl': 'assets/images/capa_comunicacao_cultura.jpg',
      'instructors': 'Professor Paulo C.',
      'duration': '30h',
      'topicId': 11,
    });

    await db.insert('courses', {
      'courseId': 56,
      'title': 'Técnicas de Vendas Avançadas',
      'description':
          'Melhore suas habilidades de vendas com técnicas avançadas.',
      'imageUrl': 'assets/images/capa_tecnicas_vendas.jpg',
      'instructors': 'Professor Ricardo M.',
      'duration': '45h',
      'topicId': 12,
    });

    await db.insert('courses', {
      'courseId': 57,
      'title': 'Negociação para Vendedores',
      'description': 'Domine a arte da negociação no processo de vendas.',
      'imageUrl': 'assets/images/capa_negociacao_vendas.jpg',
      'instructors': 'Professor Gabriela S.',
      'duration': '40h',
      'topicId': 12,
    });

    await db.insert('courses', {
      'courseId': 58,
      'title': 'Gestão de Relacionamento com Clientes',
      'description': 'Mantenha e melhore o relacionamento com seus clientes.',
      'imageUrl': 'assets/images/capa_relacionamento_clientes.jpg',
      'instructors': 'Professor Marcos F.',
      'duration': '30h',
      'topicId': 12,
    });

    await db.insert('courses', {
      'courseId': 59,
      'title': 'Psicologia das Vendas',
      'description':
          'Entenda o comportamento do consumidor para aumentar suas vendas.',
      'imageUrl': 'assets/images/capa_psicologia_vendas.jpg',
      'instructors': 'Professor Renata P.',
      'duration': '25h',
      'topicId': 12,
    });

    await db.insert('courses', {
      'courseId': 60,
      'title': 'Estratégias de Vendas Consultivas',
      'description':
          'Aprimore suas técnicas de vendas consultivas e estratégicas.',
      'imageUrl': 'assets/images/capa_vendas_consultivas.jpg',
      'instructors': 'Professor Felipe G.',
      'duration': '50h',
      'topicId': 12,
    });

    await db.insert('courses', {
      'courseId': 61,
      'title': 'Liderança Transformacional',
      'description': 'Desenvolva habilidades de liderança para inspirar e transformar sua equipe.',
      'imageUrl': 'assets/images/capa_lideranca_transformacional.jpg',
      'instructors': 'Professor Ricardo B.',
      'duration': '40h',
      'topicId': 13,
    });

    await db.insert('courses', {
      'courseId': 62,
      'title': 'Gestão de Conflitos em Equipes',
      'description': 'Aprenda a mediar conflitos e promover um ambiente colaborativo.',
      'imageUrl': 'assets/images/capa_gestao_conflitos_equipes.jpg',
      'instructors': 'Professor Vanessa C.',
      'duration': '35h',
      'topicId': 13,
    });

    await db.insert('courses', {
      'courseId': 63,
      'title': 'Tomada de Decisão para Líderes',
      'description': 'Desenvolva habilidades de tomada de decisão estratégica para sua equipe.',
      'imageUrl': 'assets/images/capa_tomada_decisao.jpg',
      'instructors': 'Professor João P.',
      'duration': '30h',
      'topicId': 13,
    });

    await db.insert('courses', {
      'courseId': 64,
      'title': 'Coaching para Líderes',
      'description': 'Aprimore suas habilidades de coaching e desenvolva seu time.',
      'imageUrl': 'assets/images/capa_coaching_lideranca.jpg',
      'instructors': 'Professor Gabriela F.',
      'duration': '25h',
      'topicId': 13,
    });

    await db.insert('courses', {
      'courseId': 65,
      'title': 'Motivação de Equipes',
      'description': 'Técnicas para manter sua equipe motivada e produtiva.',
      'imageUrl': 'assets/images/capa_motivacao_equipes.jpg',
      'instructors': 'Professor Bruno S.',
      'duration': '20h',
      'topicId': 13,
    });

    await db.insert('courses', {
      'courseId': 66,
      'title': 'Normas Regulamentadoras (NRs) de Segurança',
      'description': 'Conheça as principais normas de segurança do trabalho.',
      'imageUrl': 'assets/images/capa_normas_regulamentadoras.jpg',
      'instructors': 'Professor Luiz A.',
      'duration': '45h',
      'topicId': 14,
    });

    await db.insert('courses', {
      'courseId': 67,
      'title': 'Ergonomia no Ambiente de Trabalho',
      'description':
          'Entenda a importância da ergonomia e como aplicá-la no trabalho.',
      'imageUrl': 'assets/images/capa_ergonomia.jpg',
      'instructors': 'Professor Carla M.',
      'duration': '30h',
      'topicId': 14,
    });

    await db.insert('courses', {
      'courseId': 68,
      'title': 'Prevenção de Acidentes',
      'description':
          'Técnicas de prevenção de acidentes no ambiente de trabalho.',
      'imageUrl': 'assets/images/capa_prevencao_acidentes.jpg',
      'instructors': 'Professor Paulo T.',
      'duration': '35h',
      'topicId': 14,
    });

    await db.insert('courses', {
      'courseId': 69,
      'title': 'Segurança em Trabalhos de Risco',
      'description':
          'Protocolos de segurança para trabalhos em ambientes de risco.',
      'imageUrl': 'assets/images/capa_trabalho_risco.jpg',
      'instructors': 'Professor Fernanda L.',
      'duration': '40h',
      'topicId': 14,
    });

    await db.insert('courses', {
      'courseId': 70,
      'title': 'CIPA: Comissão Interna de Prevenção de Acidentes',
      'description': 'Treinamento completo para membros da CIPA.',
      'imageUrl': 'assets/images/capa_cipa.jpg',
      'instructors': 'Professor Roberto N.',
      'duration': '30h',
      'topicId': 14,
    });

    await db.insert('courses', {
      'courseId': 71,
      'title': 'Sustentabilidade no Mundo Corporativo',
      'description':
          'Estratégias para implantar práticas sustentáveis nas empresas.',
      'imageUrl': 'assets/images/capa_sustentabilidade_empresarial.jpg',
      'instructors': 'Professor Mariana G.',
      'duration': '40h',
      'topicId': 15,
    });

    await db.insert('courses', {
      'courseId': 72,
      'title': 'Gestão de Resíduos e Economia Circular',
      'description': 'Entenda como gerenciar resíduos de forma sustentável.',
      'imageUrl': 'assets/images/capa_gestao_residuos.jpg',
      'instructors': 'Professor Daniel M.',
      'duration': '35h',
      'topicId': 15,
    });

    await db.insert('courses', {
      'courseId': 73,
      'title': 'ISO 14001: Gestão Ambiental',
      'description':
          'Conheça a norma ISO 14001 e como aplicá-la no ambiente empresarial.',
      'imageUrl': 'assets/images/capa_iso14001.jpg',
      'instructors': 'Professor Henrique F.',
      'duration': '30h',
      'topicId': 15,
    });

    await db.insert('courses', {
      'courseId': 74,
      'title': 'Energia Renovável nas Empresas',
      'description':
          'A importância da energia renovável no ambiente corporativo.',
      'imageUrl': 'assets/images/capa_energia_renovavel.jpg',
      'instructors': 'Professor Larissa T.',
      'duration': '25h',
      'topicId': 15,
    });

    await db.insert('courses', {
      'courseId': 75,
      'title': 'Práticas de Sustentabilidade na Cadeia de Suprimentos',
      'description':
          'Implante práticas de sustentabilidade em toda a cadeia de suprimentos.',
      'imageUrl': 'assets/images/capa_sustentabilidade_cadeia.jpg',
      'instructors': 'Professor Marcos R.',
      'duration': '35h',
      'topicId': 15,
    });

    await db.insert('courses', {
      'courseId': 76,
      'title': 'Auditoria Interna e Externa',
      'description': 'Entenda os processos de auditoria nas empresas.',
      'imageUrl': 'assets/images/capa_auditoria.jpg',
      'instructors': 'Professor Ricardo S.',
      'duration': '40h',
      'topicId': 16,
    });

    await db.insert('courses', {
      'courseId': 77,
      'title': 'Compliance e Regulamentação Corporativa',
      'description': 'Conheça as melhores práticas de compliance.',
      'imageUrl': 'assets/images/capa_compliance.jpg',
      'instructors': 'Professor Lucas D.',
      'duration': '35h',
      'topicId': 16,
    });

    await db.insert('courses', {
      'courseId': 78,
      'title': 'Controles Internos e Gestão de Riscos',
      'description':
          'A importância dos controles internos para evitar fraudes e riscos.',
      'imageUrl': 'assets/images/capa_controle_riscos.jpg',
      'instructors': 'Professor Carla N.',
      'duration': '30h',
      'topicId': 16,
    });

    await db.insert('courses', {
      'courseId': 79,
      'title': 'LGPD: Lei Geral de Proteção de Dados',
      'description': 'Entenda a LGPD e como aplicar na sua empresa.',
      'imageUrl': 'assets/images/capa_lgpd.jpg',
      'instructors': 'Professor Fernanda B.',
      'duration': '25h',
      'topicId': 16,
    });

    await db.insert('courses', {
      'courseId': 80,
      'title': 'Auditoria de Processos Operacionais',
      'description':
          'Aprenda a realizar auditorias nos processos operacionais da empresa.',
      'imageUrl': 'assets/images/capa_auditoria_operacional.jpg',
      'instructors': 'Professor João F.',
      'duration': '45h',
      'topicId': 16,
    });

    await db.insert('courses', {
      'courseId': 81,
      'title': 'Fundamentos do Marketing Digital',
      'description':
          'Introdução ao marketing digital, estratégias e práticas essenciais.',
      'imageUrl': 'assets/images/capa_marketing_digital.jpg',
      'instructors': 'Professor Marcelo B.',
      'duration': '40h',
      'topicId': 17,
    });

    await db.insert('courses', {
      'courseId': 82,
      'title': 'SEO e Marketing de Conteúdo',
      'description':
          'Otimize o conteúdo para mecanismos de busca e atraia mais audiência.',
      'imageUrl': 'assets/images/capa_seo_marketing.jpg',
      'instructors': 'Professora Julia G.',
      'duration': '35h',
      'topicId': 17,
    });

    await db.insert('courses', {
      'courseId': 83,
      'title': 'Anúncios Online e Google Ads',
      'description': 'Aprenda a criar campanhas eficazes no Google Ads.',
      'imageUrl': 'assets/images/capa_google_ads.jpg',
      'instructors': 'Professor Rafael M.',
      'duration': '30h',
      'topicId': 17,
    });

    await db.insert('courses', {
      'courseId': 84,
      'title': 'Redes Sociais para Empresas',
      'description':
          'Utilize as redes sociais como ferramenta estratégica de marketing.',
      'imageUrl': 'assets/images/capa_redes_sociais_empresas.jpg',
      'instructors': 'Professor Bruno C.',
      'duration': '25h',
      'topicId': 17,
    });

    await db.insert('courses', {
      'courseId': 85,
      'title': 'Email Marketing e Automação',
      'description':
          'Desenvolva campanhas de email marketing com automação eficaz.',
      'imageUrl': 'assets/images/capa_email_marketing.jpg',
      'instructors': 'Professor Daniel F.',
      'duration': '20h',
      'topicId': 17,
    });

    await db.insert('courses', {
      'courseId': 86,
      'title': 'Inovação no Ambiente Corporativo',
      'description': 'Incorpore práticas de inovação no dia a dia da empresa.',
      'imageUrl': 'assets/images/capa_inovacao_empresarial.jpg',
      'instructors': 'Professora Marina V.',
      'duration': '40h',
      'topicId': 18,
    });

    await db.insert('courses', {
      'courseId': 87,
      'title': 'Design Thinking para Empresas',
      'description':
          'Use Design Thinking para criar soluções inovadoras e colaborativas.',
      'imageUrl': 'assets/images/capa_design_thinking.jpg',
      'instructors': 'Professor Diego A.',
      'duration': '35h',
      'topicId': 18,
    });

    await db.insert('courses', {
      'courseId': 88,
      'title': 'Criatividade no Trabalho',
      'description':
          'Desenvolva o pensamento criativo para resolver problemas complexos.',
      'imageUrl': 'assets/images/capa_criatividade_trabalho.jpg',
      'instructors': 'Professor Lucas M.',
      'duration': '30h',
      'topicId': 18,
    });

    await db.insert('courses', {
      'courseId': 89,
      'title': 'Gestão da Inovação',
      'description':
          'Saiba como implementar e gerenciar a inovação dentro de equipes.',
      'imageUrl': 'assets/images/capa_gestao_inovacao.jpg',
      'instructors': 'Professor Roberta D.',
      'duration': '25h',
      'topicId': 18,
    });

    await db.insert('courses', {
      'courseId': 90,
      'title': 'Ferramentas para Inovação',
      'description':
          'Conheça ferramentas práticas que promovem a inovação nas empresas.',
      'imageUrl': 'assets/images/capa_ferramentas_inovacao.jpg',
      'instructors': 'Professor Alexandre P.',
      'duration': '20h',
      'topicId': 18,
    });

    await db.insert('courses', {
      'courseId': 91,
      'title': 'Ética no Mundo dos Negócios',
      'description':
          'Princípios éticos e sua importância nas atividades empresariais.',
      'imageUrl': 'assets/images/capa_etica_negocios.jpg',
      'instructors': 'Professor Carlos H.',
      'duration': '30h',
      'topicId': 19,
    });

    await db.insert('courses', {
      'courseId': 92,
      'title': 'Código de Conduta Empresarial',
      'description':
          'Desenvolvimento e implementação de um código de conduta eficiente.',
      'imageUrl': 'assets/images/capa_codigo_conduta.jpg',
      'instructors': 'Professora Ana C.',
      'duration': '25h',
      'topicId': 19,
    });

    await db.insert('courses', {
      'courseId': 93,
      'title': 'Gestão Ética de Pessoas',
      'description': 'Práticas éticas na gestão de recursos humanos.',
      'imageUrl': 'assets/images/capa_gestao_etica.jpg',
      'instructors': 'Professor Pedro L.',
      'duration': '35h',
      'topicId': 19,
    });

    await db.insert('courses', {
      'courseId': 94,
      'title': 'Ética e Responsabilidade Social',
      'description':
          'Como a ética influencia a responsabilidade social nas empresas.',
      'imageUrl': 'assets/images/capa_etica_responsabilidade_social.jpg',
      'instructors': 'Professor Thiago F.',
      'duration': '40h',
      'topicId': 19,
    });

    await db.insert('courses', {
      'courseId': 95,
      'title': 'Conformidade e Ética',
      'description':
          'A relação entre conformidade normativa e práticas éticas nas empresas.',
      'imageUrl': 'assets/images/capa_conformidade_etica.jpg',
      'instructors': 'Professora Mariana S.',
      'duration': '30h',
      'topicId': 19,
    });

    await db.insert('courses', {
      'courseId': 96,
      'title': 'Introdução à Segurança da Informação',
      'description':
          'Conceitos e princípios básicos da segurança da informação.',
      'imageUrl': 'assets/images/capa_seguranca_informacao.jpg',
      'instructors': 'Professor João G.',
      'duration': '35h',
      'topicId': 20,
    });

    await db.insert('courses', {
      'courseId': 97,
      'title': 'Proteção de Dados Empresariais',
      'description':
          'Práticas e ferramentas para proteger os dados corporativos.',
      'imageUrl': 'assets/images/capa_protecao_dados.jpg',
      'instructors': 'Professor Pedro B.',
      'duration': '30h',
      'topicId': 20,
    });

    await db.insert('courses', {
      'courseId': 98,
      'title': 'Cibersegurança no Ambiente Corporativo',
      'description':
          'Estratégias e soluções de cibersegurança para proteger a empresa.',
      'imageUrl': 'assets/images/capa_ciberseguranca.jpg',
      'instructors': 'Professor Marcelo N.',
      'duration': '40h',
      'topicId': 20,
    });

    await db.insert('courses', {
      'courseId': 99,
      'title': 'Segurança em Redes e Infraestrutura',
      'description':
          'Como proteger redes e infraestruturas críticas da empresa.',
      'imageUrl': 'assets/images/capa_seguranca_redes.jpg',
      'instructors': 'Professor Roberto F.',
      'duration': '35h',
      'topicId': 20,
    });

    await db.insert('courses', {
      'courseId': 100,
      'title': 'Segurança de Aplicações e Software',
      'description':
          'Metodologias de segurança no desenvolvimento de software.',
      'imageUrl': 'assets/images/capa_seguranca_software.jpg',
      'instructors': 'Professor Leandro S.',
      'duration': '30h',
      'topicId': 20,
    });

    await db.insert('courses', {
      'courseId': 101,
      'title': 'Excelência no Atendimento ao Cliente',
      'description':
          'Princípios fundamentais para oferecer um atendimento ao cliente de alta qualidade.',
      'imageUrl': 'assets/images/capa_excelencia_atendimento.jpg',
      'instructors': 'Professora Juliana R.',
      'duration': '25h',
      'topicId': 21,
    });

    await db.insert('courses', {
      'courseId': 102,
      'title': 'Técnicas de Comunicação com o Cliente',
      'description':
          'Desenvolva habilidades de comunicação eficaz para lidar com clientes.',
      'imageUrl': 'assets/images/capa_comunicacao_cliente.jpg',
      'instructors': 'Professor Fernando B.',
      'duration': '20h',
      'topicId': 21,
    });

    await db.insert('courses', {
      'courseId': 103,
      'title': 'Gestão de Reclamações e Conflitos',
      'description':
          'Aprenda como gerenciar reclamações de clientes de forma eficaz e resolver conflitos.',
      'imageUrl': 'assets/images/capa_gestao_reclamacoes.jpg',
      'instructors': 'Professora Luiza F.',
      'duration': '30h',
      'topicId': 21,
    });

    await db.insert('courses', {
      'courseId': 104,
      'title': 'Fidelização de Clientes',
      'description':
          'Estratégias para garantir a fidelidade do cliente ao longo do tempo.',
      'imageUrl': 'assets/images/capa_fidelizacao_clientes.jpg',
      'instructors': 'Professor Rodrigo P.',
      'duration': '35h',
      'topicId': 21,
    });

    await db.insert('courses', {
      'courseId': 105,
      'title': 'Atendimento ao Cliente Digital',
      'description':
          'Técnicas e ferramentas para o atendimento ao cliente no ambiente digital.',
      'imageUrl': 'assets/images/capa_atendimento_digital.jpg',
      'instructors': 'Professor Carlos T.',
      'duration': '40h',
      'topicId': 21,
    });

    await db.insert('courses', {
      'courseId': 106,
      'title': 'Fundamentos do Planejamento Estratégico',
      'description':
          'Aprenda os conceitos e técnicas essenciais para o planejamento estratégico empresarial.',
      'imageUrl': 'assets/images/capa_planejamento_estrategico.jpg',
      'instructors': 'Professor Gustavo M.',
      'duration': '45h',
      'topicId': 22,
    });

    await db.insert('courses', {
      'courseId': 107,
      'title': 'Balanced Scorecard e KPIs',
      'description':
          'Implemente o Balanced Scorecard e defina indicadores-chave de desempenho (KPIs).',
      'imageUrl': 'assets/images/capa_balanced_scorecard.jpg',
      'instructors': 'Professora Fernanda L.',
      'duration': '35h',
      'topicId': 22,
    });

    await db.insert('courses', {
      'courseId': 108,
      'title': 'Análise SWOT no Planejamento Estratégico',
      'description':
          'Domine a ferramenta SWOT para a análise de forças, fraquezas, oportunidades e ameaças.',
      'imageUrl': 'assets/images/capa_analise_swot.jpg',
      'instructors': 'Professor Ricardo D.',
      'duration': '25h',
      'topicId': 22,
    });

    await db.insert('courses', {
      'courseId': 109,
      'title': 'Planejamento Estratégico de Longo Prazo',
      'description':
          'Técnicas e metodologias para o planejamento estratégico de longo prazo.',
      'imageUrl': 'assets/images/capa_planejamento_longo_prazo.jpg',
      'instructors': 'Professor Thiago N.',
      'duration': '50h',
      'topicId': 22,
    });

    await db.insert('courses', {
      'courseId': 110,
      'title': 'Gestão de Mudanças Estratégicas',
      'description':
          'Como implementar e gerenciar mudanças estratégicas dentro de uma organização.',
      'imageUrl': 'assets/images/capa_gestao_mudancas.jpg',
      'instructors': 'Professor Pedro S.',
      'duration': '40h',
      'topicId': 22,
    });

    await db.insert('courses', {
      'courseId': 111,
      'title': 'Estratégias de Desenvolvimento de Negócios',
      'description':
          'Crie e implemente estratégias eficazes para o desenvolvimento de novos negócios.',
      'imageUrl': 'assets/images/capa_desenvolvimento_negocios.jpg',
      'instructors': 'Professor Marcos A.',
      'duration': '40h',
      'topicId': 23,
    });

    await db.insert('courses', {
      'courseId': 112,
      'title': 'Parcerias e Alianças Estratégicas',
      'description':
          'Saiba como estabelecer parcerias estratégicas para o crescimento de negócios.',
      'imageUrl': 'assets/images/capa_parcerias_estrategicas.jpg',
      'instructors': 'Professora Karla M.',
      'duration': '30h',
      'topicId': 23,
    });

    await db.insert('courses', {
      'courseId': 113,
      'title': 'Modelos de Negócio Inovadores',
      'description':
          'Explore modelos de negócio inovadores que impulsionam o crescimento.',
      'imageUrl': 'assets/images/capa_modelos_negocio.jpg',
      'instructors': 'Professor Fernando R.',
      'duration': '35h',
      'topicId': 23,
    });

    await db.insert('courses', {
      'courseId': 114,
      'title': 'Desenvolvimento de Startups',
      'description':
          'Técnicas para desenvolver e escalar startups com sucesso.',
      'imageUrl': 'assets/images/capa_desenvolvimento_startups.jpg',
      'instructors': 'Professor Eduardo C.',
      'duration': '50h',
      'topicId': 23,
    });

    await db.insert('courses', {
      'courseId': 115,
      'title': 'Análise de Mercado para Negócios',
      'description':
          'Realize uma análise profunda de mercado para identificar oportunidades de negócios.',
      'imageUrl': 'assets/images/capa_analise_mercado.jpg',
      'instructors': 'Professor André P.',
      'duration': '45h',
      'topicId': 23,
    });

    await db.insert('courses', {
      'courseId': 116,
      'title': 'Introdução à Gestão de Facilities',
      'description':
          'Conceitos básicos e práticas de gestão de facilities em empresas.',
      'imageUrl': 'assets/images/capa_gestao_facilities.jpg',
      'instructors': 'Professor João R.',
      'duration': '30h',
      'topicId': 24,
    });

    await db.insert('courses', {
      'courseId': 117,
      'title': 'Planejamento e Operação de Facilities',
      'description':
          'Gerencie a operação e planejamento de facilities com eficiência.',
      'imageUrl': 'assets/images/capa_planejamento_facilities.jpg',
      'instructors': 'Professora Carla N.',
      'duration': '35h',
      'topicId': 24,
    });

    await db.insert('courses', {
      'courseId': 118,
      'title': 'Manutenção de Infraestrutura',
      'description':
          'Conheça as melhores práticas para a manutenção de infraestrutura empresarial.',
      'imageUrl': 'assets/images/capa_manutencao_infraestrutura.jpg',
      'instructors': 'Professor Bruno A.',
      'duration': '40h',
      'topicId': 24,
    });

    await db.insert('courses', {
      'courseId': 119,
      'title': 'Gestão de Espaços Corporativos',
      'description':
          'Aprenda como gerenciar espaços e ambientes de trabalho nas empresas.',
      'imageUrl': 'assets/images/capa_gestao_espacos.jpg',
      'instructors': 'Professor Rafael M.',
      'duration': '35h',
      'topicId': 24,
    });

    await db.insert('courses', {
      'courseId': 120,
      'title': 'Sustentabilidade em Facilities',
      'description': 'Práticas sustentáveis na gestão de facilities.',
      'imageUrl': 'assets/images/capa_sustentabilidade_facilities.jpg',
      'instructors': 'Professor Thiago L.',
      'duration': '25h',
      'topicId': 24,
    });


    // Insert inicial lições de cada curso
    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Introdução ao Flutter',
      'description': 'Aprenda o básico de Flutter.',
      'videoUrl': 'https://youtu.be/XeUiJJN0vsE?si=nho-ovlNx1VyfuhS',
    });

    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Widgets em Flutter',
      'description': 'Aprenda sobre Widgets em Flutter.',
      'videoUrl': 'https://youtu.be/dGOOR0Ujfls?si=0wE3VCA7KlncSNm1',
    });

    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Gerenciamento de Estado',
      'description': 'Entenda como gerenciar o estado em Flutter.',
      'videoUrl': 'https://youtu.be/4CCW_cdVBQg?si=NIavHbl4eUl_wYbq',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Introdução ao Java',
      'description': 'Saiba mais sobre a linguagem Java e suas vantagens.',
      'videoUrl': 'https://youtu.be/sTX0UEplF54?si=DXGij5vGBKnTFq1s',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Estruturas de Controle',
      'description': 'Aprenda sobre estruturas de controle em Java.',
      'videoUrl': 'https://youtu.be/wW3eve4vTMc?si=qMLpS3XJzWOl1ZQ6',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Orientação a Objetos',
      'description': 'Entenda os conceitos de orientação a objetos em Java.',
      'videoUrl': 'https://youtu.be/aR7CKNFECx0?si=M7PQBBSAVBCyexH7',
    });

    await db.insert('lessons', {
      'courseId': 6,
      'title': 'Introdução ao React',
      'description': 'Saiba mais sobre a biblioteca React e suas vantagens.',
      'videoUrl': 'https://youtu.be/FXqX7oof0I4?si=WRy-1xeTfrW2vUya',
    });

    await db.insert('lessons', {
      'courseId': 6,
      'title': 'Componentes em React',
      'description': 'Aprenda sobre componentes em React.',
      'videoUrl': 'https://youtu.be/-wrsG0IGc-M?si=8pztqgo-XEFKXOcv',
    });

    await db.insert('lessons', {
      'courseId': 6,
      'title': 'CSS no React',
      'description': 'Entenda como gerenciar o estado em React.',
      'videoUrl': 'https://youtu.be/20hlPRPVMoU?si=QzYJtEiAs2xuWaDI',
    });

    await db.insert('lessons', {
      'courseId': 9,
      'title': 'Introdução ao Angular',
      'description': 'Saiba mais sobre o framework Angular e suas vantagens.',
      'videoUrl': 'https://youtu.be/vJt_K1bFUeA?si=fJBTJfTsvNjj5flP',
    });

    await db.insert('lessons', {
      'courseId': 9,
      'title': 'Componentes em Angular',
      'description': 'Aprenda sobre componentes em Angular.',
      'videoUrl': 'https://youtu.be/qyS4XK_nACo?si=Amc09a0qbOvYARV-',
    });

    await db.insert('lessons', {
      'courseId': 9,
      'title': 'Serviços e Injeção de Dependência',
      'description':
          'Entenda como utilizar serviços e injeção de dependência em Angular.',
      'videoUrl': 'https://youtu.be/eRXTY5m-9c8?si=CARlvCm_bhM1itnC',
    });

    await db.insert('lessons', {
      'courseId': 42,
      'title': 'Introdução à Liderança',
      'description': 'Saiba mais sobre os conceitos de liderança.',
      'videoUrl': 'https://youtu.be/GA9wI2fMnaA?si=dBrU1-ACeW00DHPk',
    });

    await db.insert('lessons', {
      'courseId': 42,
      'title': 'Comunicação Eficaz',
      'description': 'Aprenda como se comunicar de forma eficaz.',
      'videoUrl': 'https://youtu.be/T57Rpe4NRZc?si=UPLhuXr-3viuaH3r',
    });

    await db.insert('lessons', {
      'courseId': 42,
      'title': 'Tomada de Decisão',
      'description': 'Entenda como tomar decisões assertivas.',
      'videoUrl': 'https://youtu.be/i1QX27OcC6M?si=OAGs3VbXTmJ0L0K_',
    });

    await db.insert('lessons', {
      'courseId': 81,
      'title': 'Introdução ao Marketing',
      'description': 'Saiba mais sobre os conceitos básicos de marketing.',
      'videoUrl': 'https://youtu.be/xUmHPiJg4pA?si=HwlkRLuGqjZH0Azk',
    });

    await db.insert('lessons', {
      'courseId': 81,
      'title': 'Estratégias de Marketing',
      'description': 'Aprenda sobre as principais estratégias de marketing.',
      'videoUrl': 'https://youtu.be/ywaFjp1nlXc?si=qprQ6y090iqz6esX',
    });

    await db.insert('lessons', {
      'courseId': 81,
      'title': 'Marketing Digital',
      'description': 'Entenda como utilizar o marketing digital.',
      'videoUrl': 'https://youtu.be/D2VkZAJXrLU?si=Xu6ZQWLzb-WZi7EQ',
    });

    await db.insert('lessons', {
      'courseId': 62,
      'title': 'Introdução ao Trabalho em Equipe',
      'description': 'Saiba mais sobre a importância do trabalho em equipe.',
      'videoUrl': 'https://youtu.be/RDIEK5ODQa8?si=ZdRZ1SjN_dJWI_Ab',
    });

    await db.insert('lessons', {
      'courseId': 62,
      'title': 'Comunicação no Trabalho',
      'description': 'Aprenda como colaborar de forma eficaz.',
      'videoUrl': 'https://youtu.be/sSQL5BCaCzE?si=PcxdaLbtOjHbcFQY',
    });

    await db.insert('lessons', {
      'courseId': 62,
      'title': 'Resolução de Conflitos',
      'description': 'Entenda como resolver conflitos no ambiente de trabalho.',
      'videoUrl': 'https://youtu.be/CxK5F17Dyd8?si=kikCxvOVIKSRQlgm',
    });

    await db.insert('lessons', {
      'courseId': 30,
      'title': 'Produtividade',
      'description': 'Saiba mais sobre como ser mais produtivo.',
      'videoUrl': 'https://youtu.be/OUq41ZBWVu0?si=r9WAGABDGs25ksBk',
    });

    await db.insert('lessons', {
      'courseId': 30,
      'title': 'Gestão do Tempo',
      'description': 'Aprenda a gerir melhor o seu tempo.',
      'videoUrl': 'https://youtu.be/PzUZsoyMXuY?si=B_SIFOVNGydYiFp3',
    });

    await db.insert('lessons', {
      'courseId': 30,
      'title': 'Ferramentas de Produtividade',
      'description':
          'Conheça as principais ferramentas para aumentar sua produtividade.',
      'videoUrl': 'https://youtu.be/s6_qVly-qIE?si=MlOVxCxpxE_Vsq9c',
    });

    // Insert inicial cursos que cada usuário está praticando
    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 1, // Flutter
      'progress': 0.9,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 18, // Certificações em Gestão
      'progress': 0.3,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 5, // DEVOPS
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 3,
      'courseId': 12, // Data Science para Iniciantes
      'progress': 0.5,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 3,
      'courseId': 15, // Machine Learning com Python
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 3,
      'courseId': 3, // Inteligência Artificial
      'progress': 0.2,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 4,
      'courseId': 7, // Front-End com React
      'progress': 0.6,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 4,
      'courseId': 1, // Flutter
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 4,
      'courseId': 6, // DEVOPS Práticas
      'progress': 0.3,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 5,
      'courseId': 18, // Certificações em Gestão
      'progress': 0.8,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 5,
      'courseId': 11, // Planejamento Estratégico
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 5,
      'courseId': 9, // Comunicação Eficiente
      'progress': 0.1,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 6,
      'courseId': 24, // Sustentabilidade Empresarial
      'progress': 0.9,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 6,
      'courseId': 25, // Sustentabilidade em Facilities
      'progress': 0.4,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 6,
      'courseId': 20, // Ética Empresarial
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 7,
      'courseId': 29, // Gestão de Talentos
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 7,
      'courseId': 31, // Inteligência Emocional
      'progress': 0.7,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 7,
      'courseId': 30, // Desenvolvimento Pessoal e Liderança
      'progress': 0.2,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 8,
      'courseId': 27, // Segurança da Informação
      'progress': 0.6,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 8,
      'courseId': 26, // Compliance Empresarial
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 8,
      'courseId': 15, // Data Science e Machine Learning
      'progress': 0.3,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 48, // Inteligência de Mercado e Análise Competitiva
      'progress': 0.8,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 29, // Gestão de Talentos
      'progress': 0.4,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 1,
      'progress': 0.4,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 7,
      'progress': 0.4,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 14, // Inovação e Criatividade
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 12, 
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 15, 
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 39, 
      'progress': 1.0,
      'status': 'completed',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 37, // Análise de Dados Corporativos
      'progress': 0.9,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 25, // Sustentabilidade e Inteligência Corporativa
      'progress': 0.3,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 41, 
      'progress': 0.3,
      'status': 'favorited',
    });

    await db.insert('user_courses', {
      'userId': 50,
      'courseId': 45, 
      'progress': 0.3,
      'status': 'favorited',
    });
     
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE topics(
          topicId INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');

      await db.execute('''
        ALTER TABLE courses
        ADD COLUMN topicId INTEGER REFERENCES topics(topicId)
      ''');

      // Insert inicial topics
      await db.insert('topics', {'name': 'Programação'});
      await db.insert('topics', {'name': 'Front-end'});
      await db.insert('topics', {'name': 'Desenvolvimento Pessoal'});
      await db.insert('topics', {'name': 'Marketing'});

      // Update existing courses to link with new topics
      await db.update('courses', {'topicId': 1},
          where: 'courseId = ?', whereArgs: [1]);
      await db.update('courses', {'topicId': 1},
          where: 'courseId = ?', whereArgs: [2]);
      await db.update('courses', {'topicId': 2},
          where: 'courseId = ?', whereArgs: [3]);
      await db.update('courses', {'topicId': 2},
          where: 'courseId = ?', whereArgs: [4]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [5]);
      await db.update('courses', {'topicId': 4},
          where: 'courseId = ?', whereArgs: [6]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [7]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [8]);
    }
  }

  //METODOS
  //Deletar o banco de dados/reiniciar o banco de dados
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'pharmaconnect.db');
    await databaseFactory.deleteDatabase(path);
  }

  // Método para adicionar um novo usuário
  Future<void> addUser(String name) async {
    final db = await database;
    await db.insert('users', {'name': name, 'points': 0});
  }

  // Método para adicionar pontos a um usuário
  Future<void> addPoints(int userId, int points) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE users 
      SET points = points + ? 
      WHERE userId = ?
    ''', [points, userId]);
  }

  // Método para pegar o ranking dos usuários
  Future<List<Map<String, dynamic>>> getUserRanking() async {
    final db = await database;
    final result = await db.rawQuery('''
    SELECT profiles.name, users.points 
    FROM users 
    INNER JOIN profiles 
    ON users.userId = profiles.userId 
    ORDER BY users.points DESC
  ''');
    print(result); // Log para verificar o retorno dos dados
    return result;
  }

  //Procura curso
  // Exemplo de implementação esperada
  Future<List<Map<String, dynamic>>> searchCourses(String query) async {
    final db = await openDatabase('your_database.db');
    final List<Map<String, dynamic>> courses = await db
        .rawQuery('SELECT * FROM courses WHERE title LIKE ?', ['%$query%']);
    return courses;
  }

  //Muda status do teste de perfil
  Future<void> updateTestCompletion(int userId, bool hasCompletedTest) async {
    final db = await database;
    await db.update(
      'profiles',
      {'hasCompletedTest': hasCompletedTest ? 1 : 0},
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  //Verifica se teste de perfil foi feito
  Future<bool> checkTestCompletion(int userId) async {
    final db = await database;
    final result = await db.query(
      'profiles',
      columns: ['hasCompletedTest'],
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first['hasCompletedTest'] == 1;
    }
    return false;
  }

  //Pesquisa cursos e infos a partir do user
  Future<List<Map<String, dynamic>>> getUserCoursesByStatus(
      int userId, String status) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT c.courseId, c.title, c.description, uc.progress
      FROM courses c
      JOIN user_courses uc ON c.courseId = uc.courseId
      WHERE uc.userId = ? AND uc.status = ?
    ''', [userId, status]);
  }

  //Registra usuários
  Future<int> registerUser(String email, String password) async {
    final db = await database;
    return await db.insert('users', {'email': email, 'password': password});
  }

  //Login usuários
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return result.isNotEmpty ? result.first : null;
  }

  //Salva perfis
  Future<void> saveProfile(Map<String, dynamic> profile) async {
    final db = await database;
    await db.update(
      'profiles',
      profile,
      where: 'userId = ?',
      whereArgs: [profile['userId']],
    );
  }

  Future<List<Map<String, dynamic>>> getUserCourses(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_courses',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps;
  }

  Future<void> updateProfile(
      int userId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'profiles',
      updatedFields,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<Map<String, dynamic>?> getProfile(int userId) async {
    final db = await database;
    final result =
        await db.query('profiles', where: 'userId = ?', whereArgs: [userId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> addCourse(Map<String, dynamic> course) async {
    final db = await database;
    return await db.insert('courses', course);
  }

  Future<void> addLesson(Map<String, dynamic> lesson) async {
    final db = await database;
    await db.insert('lessons', lesson);
  }

  Future<Map<String, dynamic>?> getCourseById(int courseId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'courses',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCourse(int courseId) async {
    final db = await database;
    final result =
        await db.query('courses', where: 'courseId = ?', whereArgs: [courseId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getLessons(int courseId) async {
    final db = await database;
    return await db
        .query('lessons', where: 'courseId = ?', whereArgs: [courseId]);
  }

  Future<int> insertUser(String email, String password) async {
    final db = await database;
    final userId =
        await db.insert('users', {'email': email, 'password': password});

    // Criar perfil padrão para os novos usuários
    await db.insert('profiles', {
      'userId': userId,
      'name': 'Nome Padrão',
      'certificateName': 'Nome no Certificado',
      'email': email,
      'bio': 'Bio Padrão',
      'birthDate': '01-01-2000',
      'occupation': 'Ocupação Padrão',
      'company': 'Empresa Padrão',
      'position': 'Posição Padrão',
      'linkedin': 'https://linkedin.com/in/padrao',
      'twitter': 'https://twitter.com/padrao',
      'github': 'https://github.com/padrao',
      'customLink': '',
      'course': 'Curso Padrão',
      'institution': 'Instituição Padrão',
      'educationType': 'Tipo de Educação Padrão',
      'isCompleted': 0,
      'interests': 'Interesses Padrão',
      'personalityType': 'Tipo Padrão',
      'hasCompletedTest': 0,
    });

    return userId;
  }

  // Método para atualizar informações do usuário
  Future<bool> updateUser(String email, Map<String, dynamic> values) async {
    final db = await database;
    final result = await db.update(
      'users',
      values,
      where: 'email = ?',
      whereArgs: [email],
    );

    return result > 0;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> insertCourse(Map<String, dynamic> course) async {
    final db = await database;
    await db.insert('courses', course);
  }

  Future<void> updateCourse(
      int courseId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'courses',
      updatedFields,
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
  }

  Future<void> insertLesson(Map<String, dynamic> lesson) async {
    final db = await database;
    await db.insert('lessons', lesson);
  }

  Future<void> updateLesson(
      int lessonId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'lessons',
      updatedFields,
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );
  }

  Future<void> insertTopic(Map<String, dynamic> topic) async {
    final db = await database;
    await db.insert('topics', topic);
  }

  Future<void> updateTopic(
      int topicId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'topics',
      updatedFields,
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
  }

  //MANAGE PROGRESS SCREEN
  Future<List<Map<String, dynamic>>> getAllUsersWithCourses() async {
    final db = await database;

    // Primeiro, faça a consulta unindo as tabelas profiles e users
    final result = await db.rawQuery('''
    SELECT p.userId, p.name, p.email, u.points, c.courseId, c.title, uc.status, uc.progress
    FROM profiles p
    JOIN users u ON p.userId = u.userId
    LEFT JOIN user_courses uc ON p.userId = uc.userId
    LEFT JOIN courses c ON uc.courseId = c.courseId
  ''');

    List<Map<String, dynamic>> userCourses = [];

    for (var row in result) {
      // Verificar se o usuário já foi adicionado à lista
      var existingUser = userCourses.firstWhere(
        (user) => user['userId'] == row['userId'],
        orElse: () => {},
      );

      if (existingUser.isEmpty) {
        // Adicionar novo usuário se ele ainda não estiver na lista
        userCourses.add({
          'userId': row['userId'],
          'name': row['name'],
          'email': row['email'],
          'points': row['points'],
          'courses': [],
        });
        existingUser = userCourses.last;
      }

      // Adicionar curso ao usuário
      if (row['courseId'] != null) {
        existingUser['courses'].add({
          'courseId': row['courseId'],
          'title': row['title'],
          'status': row['status'],
          'progress': row['progress'],
        });
      }
    }

    return userCourses;
  }

  Future<List<Map<String, dynamic>>> getTopics() async {
    final db = await database;
    return await db.query('topics');
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final db = await database;
    return await db.query('courses');
  }

  Future<bool> topicExists(int topicId) async {
    final db = await database;
    final result =
        await db.query('topics', where: 'topicId = ?', whereArgs: [topicId]);
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getLessonById(int lessonId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lessons',
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTopicById(int topicId) async {
    final db = await database;
    final result = await db.query(
      'topics',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> topicExist(int topicId) async {
    final db = await database;
    final result = await db.query(
      'topics',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
    return result.isNotEmpty;
  }

  Future<bool> lessonExists(int lessonId) async {
    final db = await database;
    final result = await db.query(
      'lessons',
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getLessonsSuport() async {
    final db = await database;
    return await db.query('lessons');
  }

  Future<void> deleteLesson(int lessonsId) async {
    final db = await database;
    await db.delete(
      'lessons',
      where: 'lessonsId = ?',
      whereArgs: [lessonsId],
    );
  }

  //Metodos para calculo de progresso dos cursos
  Future<List<Map<String, dynamic>>> getLessonsByCourse(int courseId) async {
    final db = await database;
    return db.query('lessons', where: 'courseId = ?', whereArgs: [courseId]);
  }

  Future<double> getUserCourseProgress(int userId, int courseId) async {
    final db = await database;
    var result = await db.query(
      'user_courses',
      columns: ['progress'],
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );

    if (result.isNotEmpty && result.first['progress'] != null) {
      return result.first['progress'] as double;
    } else {
      return 0.0;
    }
  }

  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> updateUserCourseProgress(
      int userId, int courseId, double progress) async {
    final db = await database;
    await db.update(
      'user_courses',
      {'progress': progress},
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );
  }

  Future<void> deleteTopic(int topicId) async {
    final db = await database;
    await db.delete(
      'topics',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
  }

  Future<void> markLessonAsSeen(int userId, int courseId, int lessonId) async {
    final db = await database;
    await db.insert(
        'user_lessons',
        {
          'userId': userId,
          'courseId': courseId,
          'lessonId': lessonId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> getSeenLessonsCount(int userId, int courseId) async {
    final db = await database;
    var result = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
        [userId, courseId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<bool> areAllLessonsSeen(int userId, int courseId) async {
    final db = await database;
    var totalLessonsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM lessons WHERE courseId = ?', [courseId]);
    int totalLessons = Sqflite.firstIntValue(totalLessonsResult) ?? 0;
    var seenLessonsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
        [userId, courseId]);
    int seenLessons = Sqflite.firstIntValue(seenLessonsResult) ?? 0;
    return totalLessons > 0 && totalLessons == seenLessons;
  }

  Future<void> completeCourse(int userId, int courseId) async {
    final db = await database;

    // Verifica se todas as lições foram vistas
    bool allLessonsSeen = await areAllLessonsSeen(userId, courseId);

    // Verifica se o progresso é 100%
    double progress = await getUserCourseProgress(userId, courseId);

    if (allLessonsSeen && progress >= 100.0) {
      // Atualiza o status do curso para finalizado
      await db.update(
        'user_courses',
        {'status': 'finalizado'},
        where: 'userId = ? AND courseId = ?',
        whereArgs: [userId, courseId],
      );
    }
  }

  Future<void> insertUserCourse(
      int userId, int courseId, double progress, String status) async {
    final db = await database;
    await db.insert(
      'user_courses',
      {
        'userId': userId,
        'courseId': courseId,
        'progress': progress,
        'status': status
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUserCourseStatus(
      int userId, int courseId, String status) async {
    final db = await database;
    await db.update(
      'user_courses',
      {'status': status},
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );
  }

  Future<void> deleteCourse(int courseId) async {
    final db = await database;
    await db.delete(
      'courses',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
  }

  Future<String?> getCourseStatus(int userId, int courseId) async {
    final db = await database;
    final result = await db.query(
      'user_courses',
      columns: ['status'],
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );

    if (result.isNotEmpty) {
      return result.first['status'] as String?;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getOngoingCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description, user_courses.progress
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'ongoing']);
  }

  Future<List<Map<String, dynamic>>> getFinalizedCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'finalized']);
  }

  Future<List<Map<String, dynamic>>> getFavoriteCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'favorite']);
  }

  Future<List<Map<String, dynamic>>> getCoursesStats() async {
    final db = await database;

    // Consulta para obter o número de usuários em andamento e que finalizaram cada curso
    final result = await db.rawQuery('''
    SELECT 
      c.title,
      COUNT(CASE WHEN uc.status = 'ongoing' THEN 1 END) as ongoing,
      COUNT(CASE WHEN uc.status = 'finalized' THEN 1 END) as finalized
    FROM courses c
    LEFT JOIN user_courses uc ON c.courseId = uc.courseId
    GROUP BY c.courseId
    ORDER BY c.title
  ''');

    return result;
  }

  Future<List<Map<String, dynamic>>> tickets(int userId) async {
    final db = await database;
    return db.query(
      'tickets',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> insertTicket(Map<String, dynamic> ticket) async {
    final db = await database;
    await db.insert(
      'tickets',
      ticket,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTicket(String ticketId, String status) async {
    final db = await database;
    await db.update(
      'tickets',
      {'status': status},
      where: 'ticketId = ?',
      whereArgs: [ticketId],
    );
  }
}
