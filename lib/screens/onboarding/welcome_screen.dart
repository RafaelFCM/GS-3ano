// welcome_screen.dart
import 'package:flutter/material.dart';
import 'learning_screen.dart';
import 'package:pharmaconnect_project/models/module_model.dart';
import 'package:pharmaconnect_project/models/question_model.dart';

class WelcomeScreen extends StatelessWidget {
  final int userId; // Adicione o userId como parâmetro

  WelcomeScreen({required this.userId}); // Recebe o userId

  final List<Module> modules = [
    Module(
      title: 'Módulo 1: Boas-vindas à Família Eurofarma',
      contents: [
        'Introdução: Bem-vindo à Eurofarma! Estamos felizes em tê-lo como parte de nossa equipe. A Eurofarma é uma empresa que se orgulha de sua história, missão e dos valores que a guiam.',
        'História e Missão: Fundada em 1972, a Eurofarma se estabeleceu como a primeira multinacional farmacêutica de capital 100% brasileiro. Nossa missão é promover acesso à saúde com tratamentos de qualidade e preços justos. Buscamos ser líderes no mercado farmacêutico, pautados por inovação, sustentabilidade e responsabilidade social.',
        'Cultura e Valores: Nossa cultura é baseada em quatro pilares: Inovação, Ética, Sustentabilidade e Excelência. Cada colaborador é fundamental para nosso sucesso, e esperamos que você traga suas ideias e energia para nos ajudar a crescer ainda mais.',
      ],
      questions: [
        Question(
          questionText:
              'Qual é a missão da Eurofarma?',
          options: [
            'Promover acesso à saúde com tratamentos de qualidade e preços justos.',
            'Ser a maior empresa farmacêutica do mundo.',
            'Criar medicamentos exclusivamente para o mercado brasileiro.',
            'Focar apenas em medicamentos genéricos.',
          ],
          correctAnswer: 'Promover acesso à saúde com tratamentos de qualidade e preços justos.',
        ),
        Question(
          questionText:
              'Em que ano a Eurofarma foi fundada?',
          options: [
            '1980',
            '1972',
            '1990',
            '1965',
          ],
          correctAnswer: '1972',
        ),
        Question(
          questionText:
              'Quantos pilares principais sustentam a cultura da Eurofarma?',
          options: [
            '2',
            '4',
            '5',
            '6',
          ],
          correctAnswer: '4',
        ),
        Question(
          questionText:
              'Qual é um dos pilares da cultura da Eurofarma?',
          options: [
            'Individualismo',
            'Inovação',
            'Competição',
            'Exclusividade',
          ],
          correctAnswer: 'Inovação',
        ),
      ],
    ),
    Module(
      title: 'Módulo 2: Introdução à Empresa',
      contents: [
        'Histórico de Crescimento: Desde sua fundação, a Eurofarma expandiu-se para 22 países, estabelecendo-se como uma das principais empresas farmacêuticas da América Latina. Nossa trajetória é marcada por inovações e aquisições estratégicas que nos permitiram crescer e diversificar nosso portfólio.',
        'Estrutura Organizacional: A Eurofarma é composta por várias divisões que trabalham de forma integrada para atender às demandas do mercado farmacêutico. Cada departamento, desde Pesquisa & Desenvolvimento até Vendas e Marketing, desempenha um papel essencial.',
        'Posição no Mercado: Atuamos em várias áreas, como prescrição médica, genéricos, oncologia, e hospitalar, consolidando nossa posição de liderança no mercado.',
      ],
      questions: [
        Question(
          questionText: 'Quantos países a Eurofarma está presente atualmente?',
          options: [
            '10',
            '15',
            '22',
            '30',
          ],
          correctAnswer: '22',
        ),
        Question(
          questionText: 'Qual área NÃO faz parte das operações da Eurofarma?',
          options: [
            'Prescrição médica',
            'Genéricos',
            'Hospitalar',
            'Agricultura',
          ],
          correctAnswer: 'Agricultura',
        ),
        Question(
          questionText:
              'Qual é o papel da estrutura organizacional da Eurofarma?',
          options: [
            'Integrar as divisões para atender ao mercado farmacêutico.',
            'Reduzir custos de produção.',
            'Centralizar todas as operações no Brasil.',
            'Focar exclusivamente na pesquisa e desenvolvimento.',
          ],
          correctAnswer:
              'Integrar as divisões para atender ao mercado farmacêutico.',
        ),
        Question(
          questionText: 'Qual é uma das áreas de atuação da Eurofarma?',
          options: [
            'Desenvolvimento de software',
            'Oncologia',
            'Agricultura',
            'Moda',
          ],
          correctAnswer: 'Oncologia',
        ),
      ],
    ),
    Module(
      title: 'Módulo 3: Ferramentas e Sistemas',
      contents: [
        'Comunicação Interna: Utilizamos ferramentas como e-mail corporativo e Microsoft Teams para garantir uma comunicação eficiente e integrada entre as equipes. É essencial manter a caixa de entrada organizada e utilizar os canais adequados para diferentes tipos de comunicação.',
        'Sistemas de Gestão: Nosso ERP (Enterprise Resource Planning) integra todas as áreas da empresa, desde finanças até logística, permitindo uma gestão eficaz e centralizada dos processos.',
        'Portais Internos: O Portal RH e a Intranet são ferramentas essenciais para acessar informações sobre folha de pagamento, benefícios, políticas internas e notícias corporativas.',
      ],
      questions: [
        Question(
          questionText:
              'Qual ferramenta a Eurofarma usa para comunicação interna?',
          options: [
            'Slack',
            'Microsoft Teams',
            'WhatsApp',
            'Google Meet',
          ],
          correctAnswer: 'Microsoft Teams',
        ),
        Question(
          questionText: 'O que o ERP da Eurofarma faz?',
          options: [
            'Integra todas as áreas da empresa',
            'Apenas gerencia a folha de pagamento',
            'Serve para comunicar com clientes',
            'Organiza eventos da empresa',
          ],
          correctAnswer: 'Integra todas as áreas da empresa',
        ),
        Question(
          questionText:
              'Qual portal é usado para acessar informações sobre folha de pagamento e benefícios?',
          options: [
            'Portal RH',
            'Portal do Colaborador',
            'Intranet',
            'Portal de Compras',
          ],
          correctAnswer: 'Portal RH',
        ),
        Question(
          questionText:
              'Qual é um dos sistemas mencionados para gestão na Eurofarma?',
          options: [
            'ERP',
            'SAP',
            'CRM',
            'SQL',
          ],
          correctAnswer: 'ERP',
        ),
      ],
    ),
    Module(
      title: 'Módulo 4: Funções e Responsabilidades',
      contents: [
        'Descrição do Cargo: Como parte da Eurofarma, você será responsável por garantir que todas as suas atividades estejam alinhadas com nossos padrões de qualidade e ética. Cada função tem um papel crucial no cumprimento de nossa missão.',
        'Integração Interdepartamental: Trabalhar em conjunto com outros departamentos é essencial para o sucesso de nossas operações. A comunicação e a colaboração são fundamentais para alcançar nossos objetivos.',
        'Metas e Avaliação: Você será avaliado com base no cumprimento de metas estabelecidas e na sua capacidade de colaborar com a equipe. Expectativas claras serão definidas para que você saiba exatamente como contribuir para o sucesso da empresa.',
      ],
      questions: [
        Question(
          questionText:
              'Como são definidas as metas de um colaborador na Eurofarma?',
          options: [
            'São aleatórias',
            'Baseadas no cumprimento de metas e colaboração',
            'Definidas pelo mercado',
            'Seguem a agenda do CEO',
          ],
          correctAnswer: 'Baseadas no cumprimento de metas e colaboração',
        ),
        Question(
          questionText: 'Qual é o papel de um colaborador da Eurofarma?',
          options: [
            'Seguir ordens sem questionar',
            'Trabalhar individualmente',
            'Alinhar atividades com padrões de qualidade e ética',
            'Focar apenas em vendas',
          ],
          correctAnswer: 'Alinhar atividades com padrões de qualidade e ética',
        ),
        Question(
          questionText:
              'O que é essencial para o sucesso das operações na Eurofarma?',
          options: [
            'Competição interna',
            'Comunicação e colaboração',
            'Segredo e isolamento',
            'Redução de custos',
          ],
          correctAnswer: 'Comunicação e colaboração',
        ),
        Question(
          questionText:
              'Com quem o colaborador deve trabalhar para ter sucesso?',
          options: [
            'Apenas com seu gerente',
            'Com outros departamentos',
            'Com clientes',
            'Somente com a equipe de vendas',
          ],
          correctAnswer: 'Com outros departamentos',
        ),
      ],
    ),
    Module(
      title: 'Módulo 5: Integração com a Equipe',
      contents: [
        'Apresentação da Equipe: Durante o primeiro mês, você será apresentado aos membros da sua equipe e participará de reuniões e dinâmicas para conhecer melhor o funcionamento do grupo.',
        'Cultura de Colaboração: Na Eurofarma, incentivamos a troca de ideias e o trabalho em equipe. Acreditamos que a colaboração entre os departamentos é a chave para a inovação e para o alcance de resultados superiores.',
        'Mentoria e Apoio: Cada novo colaborador é acompanhado por um mentor, que estará disponível para orientá-lo e ajudá-lo na adaptação ao ambiente de trabalho. Sessões de feedback serão realizadas regularmente para garantir que você esteja confortável em sua nova função.',
      ],
      questions: [
        Question(
          questionText:
              'Quem ajuda o novo colaborador a se integrar na equipe?',
          options: [
            'O CEO',
            'Um mentor',
            'Um consultor externo',
            'O gerente financeiro',
          ],
          correctAnswer: 'Um mentor',
        ),
        Question(
          questionText: 'O que a Eurofarma incentiva na cultura de trabalho?',
          options: [
            'Trabalho isolado',
            'Troca de ideias e trabalho em equipe',
            'Hierarquia rígida',
            'Evitar comunicação',
          ],
          correctAnswer: 'Troca de ideias e trabalho em equipe',
        ),
        Question(
          questionText: 'Como o colaborador será apresentado à equipe?',
          options: [
            'Em uma festa',
            'Durante o primeiro mês, em reuniões e dinâmicas',
            'Em uma videoconferência',
            'Apenas por e-mail',
          ],
          correctAnswer: 'Durante o primeiro mês, em reuniões e dinâmicas',
        ),
        Question(
          questionText: 'Qual é o papel do mentor na integração?',
          options: [
            'Avaliar o desempenho do colaborador',
            'Orientar e ajudar na adaptação',
            'Definir o salário do colaborador',
            'Organizar eventos sociais',
          ],
          correctAnswer: 'Orientar e ajudar na adaptação',
        ),
      ],
    ),
    Module(
      title: 'Módulo 6: Desenvolvimento e Crescimento',
      contents: [
        'Programas de Treinamento: A Eurofarma oferece uma ampla gama de treinamentos técnicos e comportamentais, desde cursos online até programas de desenvolvimento de liderança. Nossa plataforma de e-learning é uma excelente ferramenta para você aprimorar suas habilidades.',
        'Plano de Carreira: Incentivamos o crescimento interno e temos planos de carreira estruturados que permitem aos colaboradores visualizarem suas possibilidades de desenvolvimento dentro da empresa. Suas promoções serão baseadas no seu desempenho e alinhamento com os valores da Eurofarma.',
        'Autodesenvolvimento: Além dos treinamentos formais, oferecemos acesso a uma biblioteca digital com livros e cursos que você pode explorar de acordo com seus interesses e necessidades de desenvolvimento.',
      ],
      questions: [
        Question(
          questionText:
              'O que a Eurofarma oferece para o desenvolvimento dos colaboradores?',
          options: [
            'Apenas treinamentos técnicos',
            'Uma ampla gama de treinamentos técnicos e comportamentais',
            'Nada, o aprendizado é individual',
            'Apenas cursos presenciais',
          ],
          correctAnswer:
              'Uma ampla gama de treinamentos técnicos e comportamentais',
        ),
        Question(
          questionText:
              'Como os colaboradores podem visualizar suas oportunidades de crescimento?',
          options: [
            'Através do plano de carreira',
            'Somente conversando com o gerente',
            'Não há plano de carreira',
            'Em reuniões anuais',
          ],
          correctAnswer: 'Através do plano de carreira',
        ),
        Question(
          questionText: 'Como são decididas as promoções na Eurofarma?',
          options: [
            'Baseadas em tempo de serviço',
            'Com base no desempenho e alinhamento com os valores',
            'Por sorteio',
            'Automaticamente após 5 anos',
          ],
          correctAnswer: 'Com base no desempenho e alinhamento com os valores',
        ),
        Question(
          questionText:
              'Qual ferramenta é mencionada para autodesenvolvimento?',
          options: [
            'Biblioteca digital',
            'Sala de reuniões',
            'Agenda do gerente',
            'Conferências externas',
          ],
          correctAnswer: 'Biblioteca digital',
        ),
      ],
    ),
    Module(
      title: 'Módulo 7: Políticas e Procedimentos',
      contents: [
        'Código de Ética e Conduta: Nosso Código de Ética é a base para todas as nossas ações. Ele orienta como devemos agir em diversas situações, sempre com integridade, respeito e transparência. Todos os colaboradores devem seguir essas diretrizes.',
        'Segurança e Saúde no Trabalho: A segurança dos nossos colaboradores é uma prioridade. Temos políticas rigorosas que garantem um ambiente de trabalho seguro, e todos devem estar familiarizados com os procedimentos de emergência e o uso correto de Equipamentos de Proteção Individual (EPIs).',
        'Compliance e Regulamentos: Como uma empresa do setor farmacêutico, estamos sujeitos a uma série de regulamentos locais e internacionais. Garantir a conformidade com essas normas é fundamental para manter nossa credibilidade e sucesso.',
      ],
      questions: [
        Question(
          questionText: 'Qual é a base para todas as ações na Eurofarma?',
          options: [
            'Inovação Tecnológica',
            'Código de Ética e Conduta',
            'Redução de Custos',
            'Expansão Internacional',
          ],
          correctAnswer: 'Código de Ética e Conduta',
        ),
        Question(
          questionText: 'O que a Eurofarma prioriza no ambiente de trabalho?',
          options: [
            'Alta competitividade',
            'Segurança e saúde dos colaboradores',
            'Lucros rápidos',
            'Individualismo',
          ],
          correctAnswer: 'Segurança e saúde dos colaboradores',
        ),
        Question(
          questionText:
              'O que é essencial para manter a credibilidade da Eurofarma?',
          options: [
            'Marketing agressivo',
            'Conformidade com regulamentos locais e internacionais',
            'Treinamentos semanais',
            'Produtos inovadores',
          ],
          correctAnswer:
              'Conformidade com regulamentos locais e internacionais',
        ),
        Question(
          questionText: 'O que todos os colaboradores devem seguir?',
          options: [
            'Diretrizes de vendas',
            'Código de Ética',
            'Procedimentos de finanças',
            'Regras de vestimenta',
          ],
          correctAnswer: 'Código de Ética',
        ),
      ],
    ),
    Module(
      title: 'Módulo 8: Propósito, Manifesto e Objetivos',
      contents: [
        'Propósito da Eurofarma: Nosso propósito é claro: transformar a saúde e a qualidade de vida das pessoas através de medicamentos inovadores e acessíveis. Cada colaborador desempenha um papel vital na realização deste propósito.',
        'Manifesto da Eurofarma: Acreditamos que todos os nossos esforços devem estar alinhados com a nossa missão de promover acesso à saúde de qualidade. Nossos valores nos guiam em cada decisão e ação que tomamos.',
        'Objetivos Estratégicos: Nossos objetivos incluem expandir nossa presença global, inovar em nossas linhas de produtos e manter os mais altos padrões de qualidade e sustentabilidade. Todos nós contribuímos para atingir essas metas, seja na linha de produção, no laboratório ou no escritório.',
      ],
      questions: [
        Question(
          questionText: 'Qual é o propósito da Eurofarma?',
          options: [
            'Aumentar lucros',
            'Transformar a saúde e a qualidade de vida das pessoas',
            'Expandir para todos os continentes',
            'Criar novos medicamentos patenteados',
          ],
          correctAnswer:
              'Transformar a saúde e a qualidade de vida das pessoas',
        ),
        Question(
          questionText: 'O que guia cada decisão na Eurofarma?',
          options: [
            'O mercado financeiro',
            'O Manifesto da Eurofarma',
            'Consultorias externas',
            'A opinião pública',
          ],
          correctAnswer: 'O Manifesto da Eurofarma',
        ),
        Question(
          questionText: 'Qual é um dos objetivos estratégicos da Eurofarma?',
          options: [
            'Reduzir o número de funcionários',
            'Expandir a presença global',
            'Focar em um único produto',
            'Ter apenas operações no Brasil',
          ],
          correctAnswer: 'Expandir a presença global',
        ),
        Question(
          questionText:
              'Em quais áreas a Eurofarma busca manter padrões elevados?',
          options: [
            'Marketing e publicidade',
            'Qualidade e sustentabilidade',
            'Somente em produção',
            'Vendas e lucros',
          ],
          correctAnswer: 'Qualidade e sustentabilidade',
        ),
      ],
    ),
    Module(
      title: 'Módulo 9: Diversidade, Equidade e Inclusão',
      contents: [
        'Objetivo: Promover a importância da diversidade e inclusão dentro da Eurofarma.',
        'Programa Eurofarma +Diverso: Desde 2020, o Programa Eurofarma +Diverso trabalha em quatro frentes prioritárias: Raça, Gênero, LGBTQIA+, Pessoas com Deficiência e combate ao Etarismo. Nosso objetivo é criar um ambiente de trabalho inclusivo e justo, onde todos se sintam valorizados e representados.',
        'Políticas de Diversidade e Inclusão: A Eurofarma se compromete a promover a diversidade em todas as suas formas. Temos políticas claras para garantir que todos tenham oportunidades iguais e possam prosperar em suas carreiras.',
        'Grupos de Afinidade: Incentivamos a formação de grupos de afinidade que discutem e promovem ações que apoiam a inclusão e a diversidade dentro da empresa. Todos os colaboradores são convidados a participar e contribuir.',
      ],
      questions: [
        Question(
          questionText: 'Qual programa da Eurofarma promove a diversidade?',
          options: [
            'Eurofarma Excelência',
            'Eurofarma +Diverso',
            'Eurofarma Avançada',
            'Eurofarma Inclusão',
          ],
          correctAnswer: 'Eurofarma +Diverso',
        ),
        Question(
          questionText:
              'Quais frentes prioritárias o programa Eurofarma +Diverso trabalha?',
          options: [
            'Raça, Gênero, LGBTQIA+, Pessoas com Deficiência e combate ao Etarismo',
            'Finanças, Vendas, Marketing, Logística',
            'Somente Raça e Gênero',
            'Liderança e Gestão',
          ],
          correctAnswer:
              'Raça, Gênero, LGBTQIA+, Pessoas com Deficiência e combate ao Etarismo',
        ),
        Question(
          questionText: 'Como a Eurofarma promove a inclusão?',
          options: [
            'Criando grupos de afinidade',
            'Através de treinamentos obrigatórios',
            'Somente com eventos anuais',
            'Com parcerias externas',
          ],
          correctAnswer: 'Criando grupos de afinidade',
        ),
        Question(
          questionText:
              'Qual é o objetivo das políticas de diversidade da Eurofarma?',
          options: [
            'Melhorar a imagem da empresa',
            'Criar um ambiente de trabalho inclusivo e justo',
            'Aumentar as vendas',
            'Reduzir custos',
          ],
          correctAnswer: 'Criar um ambiente de trabalho inclusivo e justo',
        ),
      ],
    ),
    Module(
      title: 'Módulo 10: Sustentabilidade e Responsabilidade Social',
      contents: [
        'Visão 2027 e Cartilha Sustentável: A Eurofarma tem um plano de longo prazo para a sustentabilidade, alinhado à nossa Visão 2027. Este plano inclui ações que vão desde a redução do consumo de recursos naturais até a promoção de projetos sociais que beneficiam as comunidades onde atuamos.',
        'Práticas de Sustentabilidade: Nossas unidades operacionais, como o Complexo Industrial de Itapevi, estão equipadas com tecnologias que promovem o uso eficiente de recursos, incluindo captação de água da chuva e geração de energia solar.',
        'Iniciativas de Responsabilidade Social: A Eurofarma apoia diversas iniciativas sociais e ambientais, reforçando nosso compromisso com o desenvolvimento sustentável e com a criação de valor para a sociedade.',
      ],
      questions: [
        Question(
          questionText: 'O que a Eurofarma prioriza em sua Visão 2027?',
          options: [
            'Expansão geográfica',
            'Sustentabilidade e responsabilidade social',
            'Redução de custos operacionais',
            'Aumento de produção',
          ],
          correctAnswer: 'Sustentabilidade e responsabilidade social',
        ),
        Question(
          questionText:
              'Qual é uma prática sustentável do Complexo Industrial de Itapevi?',
          options: [
            'Uso de energia térmica',
            'Geração de energia solar e captação de água da chuva',
            'Produção de medicamentos genéricos',
            'Expansão da planta',
          ],
          correctAnswer: 'Geração de energia solar e captação de água da chuva',
        ),
        Question(
          questionText: 'Qual é o compromisso da Eurofarma com a sociedade?',
          options: [
            'Foco em vendas',
            'Criar medicamentos caros',
            'Apoiar iniciativas sociais e ambientais',
            'Crescer apenas na América Latina',
          ],
          correctAnswer: 'Apoiar iniciativas sociais e ambientais',
        ),
        Question(
          questionText:
              'Como a Eurofarma demonstra seu compromisso com a sustentabilidade?',
          options: [
            'Através de eventos sociais',
            'Com redução do uso de recursos naturais',
            'Com aumento de preços',
            'Com marketing sustentável',
          ],
          correctAnswer: 'Com redução do uso de recursos naturais',
        ),
      ],
    ),
    Module(
      title: 'Módulo 11: Infraestrutura e Presença Global',
      contents: [
        'Presença Global: A Eurofarma está presente em 22 países e possui 12 fábricas, das quais cinco estão localizadas no Brasil. Nosso alcance global nos permite atuar em mercados diversificados e atender milhões de pessoas com medicamentos de alta qualidade.',
        'Complexo Industrial de Itapevi: Localizado em São Paulo, o Complexo Industrial de Itapevi é uma das plantas mais avançadas da América Latina, responsável por 70% da produção de medicamentos da Eurofarma. Essa unidade é um exemplo de inovação e sustentabilidade, utilizando tecnologias que incluem captação de água da chuva e geração de energia solar.',
        'Logística e Distribuição: Com uma rede logística robusta, a Eurofarma garante que seus produtos cheguem com rapidez e segurança a todos os mercados onde atua. Nosso foco é manter a excelência em toda a cadeia de distribuição.',
      ],
      questions: [
        Question(
          questionText: 'Quantas fábricas a Eurofarma possui globalmente?',
          options: [
            '8',
            '10',
            '12',
            '15',
          ],
          correctAnswer: '12',
        ),
        Question(
          questionText:
              'Onde está localizado o Complexo Industrial de Itapevi?',
          options: [
            'Rio de Janeiro',
            'São Paulo',
            'Minas Gerais',
            'Brasília',
          ],
          correctAnswer: 'São Paulo',
        ),
        Question(
          questionText:
              'Qual é um dos benefícios da rede logística da Eurofarma?',
          options: [
            'Aumentar os lucros',
            'Garantir que produtos cheguem com rapidez e segurança',
            'Reduzir o número de entregas',
            'Ampliar a produção interna',
          ],
          correctAnswer:
              'Garantir que produtos cheguem com rapidez e segurança',
        ),
        Question(
          questionText: 'O que caracteriza o Complexo Industrial de Itapevi?',
          options: [
            'Localizado no centro da cidade',
            'Uma das plantas mais avançadas da América Latina',
            'Produção exclusiva de medicamentos genéricos',
            'Pequeno porte',
          ],
          correctAnswer: 'Uma das plantas mais avançadas da América Latina',
        ),
      ],
    ),
    Module(
      title: 'Módulo 12: Parcerias e Inovação',
      contents: [
        'Novos Negócios e Parcerias Estratégicas: A Eurofarma investe em parcerias estratégicas e expansões globais através de fusões, aquisições, e joint ventures. Essas parcerias são fundamentais para nosso crescimento e representam aproximadamente 10% do nosso faturamento.',
        'EurON Open Innovation: O EurON é a nossa plataforma de inovação aberta, criada para fomentar a colaboração com startups e empresas de tecnologia. O objetivo é desenvolver soluções inovadoras que agreguem valor ao nosso negócio e ao setor de saúde como um todo.',
        'Eurolab: Nosso centro de inovação, Eurolab, localizado em Itapevi, é dedicado ao desenvolvimento de novos medicamentos. Com laboratórios de última geração e uma mini fábrica para produção de medicamentos para estudos clínicos, o Eurolab reflete nosso compromisso com a inovação e a sustentabilidade.',
      ],
      questions: [
        Question(
          questionText: 'O que é o EurON?',
          options: [
            'Plataforma de vendas',
            'Plataforma de inovação aberta',
            'Sistema de gerenciamento de estoque',
            'Programa de treinamento',
          ],
          correctAnswer: 'Plataforma de inovação aberta',
        ),
        Question(
          questionText: 'O que o Eurolab faz?',
          options: [
            'Produz apenas medicamentos genéricos',
            'Desenvolve novos medicamentos e realiza estudos clínicos',
            'Foca em marketing',
            'Gerencia recursos humanos',
          ],
          correctAnswer:
              'Desenvolve novos medicamentos e realiza estudos clínicos',
        ),
        Question(
          questionText:
              'Qual é o objetivo das parcerias estratégicas da Eurofarma?',
          options: [
            'Aumentar a competitividade interna',
            'Fomentar crescimento através de fusões, aquisições e joint ventures',
            'Reduzir o número de funcionários',
            'Aumentar o marketing digital',
          ],
          correctAnswer:
              'Fomentar crescimento através de fusões, aquisições e joint ventures',
        ),
        Question(
          questionText: 'Como a Eurofarma inova no mercado?',
          options: [
            'Através do Eurolab e parcerias com startups',
            'Apenas com produtos antigos',
            'Sem parcerias',
            'Com estratégias de marketing',
          ],
          correctAnswer: 'Através do Eurolab e parcerias com startups',
        ),
      ],
    ),
    Module(
      title: 'Módulo 13: Certificações e Qualidade',
      contents: [
        'Certificações de Qualidade: A Eurofarma segue as Boas Práticas de Fabricação (GMP) e outras regulamentações internacionais para garantir a segurança e eficácia de seus produtos. Somos regularmente auditados para assegurar que todas as nossas operações estejam em conformidade com esses padrões.',
        'Compromisso com a Excelência: A qualidade é a nossa prioridade número um. Nossos processos de produção são continuamente aprimorados para manter os mais altos níveis de qualidade e segurança.',
        'Reconhecimento Internacional: Nossas certificações refletem nosso compromisso com a excelência e nos posicionam como uma das líderes no setor farmacêutico global.',
      ],
      questions: [
        Question(
          questionText:
              'Quais práticas a Eurofarma segue para garantir a qualidade?',
          options: [
            'Boas Práticas de Fabricação (GMP)',
            'Normas locais apenas',
            'Somente práticas internas',
            'Normas antigas de qualidade',
          ],
          correctAnswer: 'Boas Práticas de Fabricação (GMP)',
        ),
        Question(
          questionText: 'Qual é o foco número um da Eurofarma?',
          options: [
            'Qualidade',
            'Marketing',
            'Crescimento rápido',
            'Produção em massa',
          ],
          correctAnswer: 'Qualidade',
        ),
        Question(
          questionText: 'Como a Eurofarma mantém altos padrões de qualidade?',
          options: [
            'Sem controles específicos',
            'Com auditorias regulares e melhorias contínuas nos processos',
            'Com marketing agressivo',
            'Apenas com produtos novos',
          ],
          correctAnswer:
              'Com auditorias regulares e melhorias contínuas nos processos',
        ),
        Question(
          questionText: 'O que as certificações da Eurofarma refletem?',
          options: [
            'A inovação tecnológica',
            'O compromisso com a excelência',
            'A eficiência operacional',
            'O foco em marketing',
          ],
          correctAnswer: 'O compromisso com a excelência',
        ),
      ],
    ),
    Module(
      title: 'Módulo 14: Prêmios e Reconhecimentos',
      contents: [
        'Prêmios de Inovação e Sustentabilidade: A Eurofarma é reconhecida por seu pioneirismo em inovação e práticas de sustentabilidade. Somos a única farmacêutica hexacampeã do Guia Exame ESG, o que demonstra nosso compromisso com as melhores práticas ambientais, sociais e de governança.',
        'Melhores Empresas para Trabalhar: Estamos há 20 anos consecutivos entre as melhores empresas para trabalhar no Brasil, segundo o GPTW. Este reconhecimento reflete o nosso compromisso com o bem-estar e o desenvolvimento dos nossos colaboradores.',
        'Reconhecimento Global: Nossos prêmios e reconhecimentos internacionais demonstram a força e a qualidade do trabalho que realizamos em todos os mercados onde atuamos.',
      ],
      questions: [
        Question(
          questionText:
              'Qual prêmio a Eurofarma ganhou por suas práticas de sustentabilidade?',
          options: [
            'Prêmio de Inovação Tecnológica',
            'Guia Exame ESG',
            'Prêmio de Marketing',
            'Melhor Campanha Publicitária',
          ],
          correctAnswer: 'Guia Exame ESG',
        ),
        Question(
          questionText:
              'Qual reconhecimento a Eurofarma recebeu por seu ambiente de trabalho?',
          options: [
            'Melhor Treinamento Corporativo',
            '20 anos entre as melhores empresas para trabalhar no Brasil pelo GPTW',
            'Maior Produtividade',
            'Melhor Marketing',
          ],
          correctAnswer:
              '20 anos entre as melhores empresas para trabalhar no Brasil pelo GPTW',
        ),
        Question(
          questionText:
              'Qual área da Eurofarma é reconhecida internacionalmente?',
          options: [
            'Suporte ao cliente',
            'Pesquisa e Desenvolvimento',
            'Vendas',
            'Recursos Humanos',
          ],
          correctAnswer: 'Pesquisa e Desenvolvimento',
        ),
        Question(
          questionText: 'Os prêmios da Eurofarma demonstram o quê?',
          options: [
            'Foco apenas em vendas',
            'A excelência e liderança no setor farmacêutico',
            'Competição interna',
            'Crescimento rápido',
          ],
          correctAnswer: 'A excelência e liderança no setor farmacêutico',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              'Bem-Vindo ao Onboarding da Eurofarma',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Aqui você aprenderá tudo sobre a sua empresa',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Junte-se a nós nessa jornada de aprendizado e desenvolvimento. Nós passaremos por diversos assuntos importantíssimos.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(modules[index].title),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // Navega para LearningScreen com o título correto do módulo
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearningScreen(
                              module: modules[index],
                              modules:
                                  modules, // Passe a lista completa de módulos
                              currentModuleIndex:
                                  index,
                                  userId: userId, // Passe o índice do módulo atual
                            ),
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
