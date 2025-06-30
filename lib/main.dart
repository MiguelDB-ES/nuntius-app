// lib/main.dart
import 'package:flutter/material.dart';
import 'package:nuntius/app.dart';
// VERIFIQUE: O caminho deve ser 'package:nuntius/data/database/database_helper.dart'
// e o nome do pacote 'nuntius' deve ser exatamente o que está no seu pubspec.yaml.
import 'package:nuntius/data/database/schemas/database_helper.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Inicializa o banco de dados. Isso criará o banco e as tabelas se não existirem.
    await DatabaseHelper.instance.database;
    print('Banco de dados Nuntius inicializado com sucesso!');
  } catch (e) {
    print('Erro ao inicializar o banco de dados: $e');
    // Em um app real, você pode mostrar um dialog de erro aqui e/ou sair do app.
  }

  runApp(const NuntiusApp());
}
