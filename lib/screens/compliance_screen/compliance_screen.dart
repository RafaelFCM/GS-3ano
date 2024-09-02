import 'package:flutter/material.dart';

class ComplianceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recursos de Compliance'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Sobre os recursos'),
              Text(
                'Esta página contém recursos e informações importantes sobre Compliance na Eurofarma. Aqui você encontrará links úteis para regulamentações e normas, além de um glossário com definições de termos relevantes. O objetivo é fornecer uma visão geral e acesso a materiais essenciais para assegurar a conformidade com as políticas e regulamentos.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Links'),
              _buildLink('Lei Geral de Proteção de Dados (LGPD)'),
              _buildLink(
                  'Normas Regulamentadoras de Segurança e Saúde no Trabalho (NRs)'),
              SizedBox(height: 20),
              _buildSectionTitle('Sites Importantes'),
              _buildLink('Portal da Transparência'),
              _buildLink('Controladoria-Geral da União (CGU)'),
              SizedBox(height: 20),
              _buildAccordionSection(
                'Glossário de Termos',
                [
                  'Due Diligence',
                  'Risco de Compliance',
                  'Auditoria de Compliance',
                ],
              ),
              _buildAccordionSection(
                'Políticas Internas',
                [
                  'Política de Conduta Ética',
                  'Política de Sustentabilidade',
                  'Política de Privacidade',
                ],
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Relatórios de Não-Conformidade'),
              _buildAccordionSection(
                'Tópicos de Qualidade',
                [
                  'Relatório de Desvios de Qualidade',
                  'Registros de Controle de Qualidade',
                  'Análise de Falhas de Qualidade',
                ],
              ),
              _buildAccordionSection(
                'Tópicos de Segurança',
                [
                  'Relatório de Incidentes de Segurança',
                  'Registro de Desvios de Segurança',
                  'Monitoramento de Conformidade em Segurança',
                ],
              ),
              _buildAccordionSection(
                'Tópicos de Processos',
                [
                  'Relatório de Desvios em Processos Operacionais',
                  'Registros de Não Conformidade em Processos',
                  'Análise de Ineficiências de Processo',
                ],
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Manuais de Conduta'),
              _buildAccordionSection(
                'Tópicos de Conduta Ética',
                [
                  'Manual de Conduta Ética',
                  'Guia de Comportamento Profissional',
                  'Código de Ética Empresarial',
                ],
              ),
              _buildAccordionSection(
                'Tópicos de Conformidade Legal',
                [
                  'Manual de Compliance Legal',
                  'Guia de Conformidade Regulatória',
                  'Políticas de Conformidade com Leis',
                ],
              ),
              _buildAccordionSection(
                'Tópicos de Responsabilidade Social',
                [
                  'Manual de Responsabilidade Social',
                  'Guia de Sustentabilidade Corporativa',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[700],
      ),
    );
  }

  Widget _buildLink(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.link, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionSection(String title, List<String> items) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: items.map((item) {
        return ListTile(
          title: Text(item),
        );
      }).toList(),
    );
  }
}
