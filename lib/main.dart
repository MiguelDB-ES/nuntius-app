// lib/main.dart
import 'package:flutter/material.dart';
import 'package:nuntius/app.dart';
import 'package:nuntius/data/database/schemas/database_helper.dart';
import 'package:nuntius/data/services/user_service.dart'; // NOVO: Importe o UserService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Inicializa o banco de dados. Isso criará o banco e as tabelas se não existirem.
    await DatabaseHelper.instance.database;
    print('Banco de dados Nuntius inicializado com sucesso!');

    // NOVO: Carrega os dados do usuário ao iniciar o app
    await UserService().loadUserData();
    print('Dados do usuário carregados com sucesso!');

  } catch (e) {
    print('Erro ao inicializar o banco de dados ou carregar dados do usuário: $e');
    // Em um app real, você pode mostrar um dialog de erro aqui e/ou sair do app.
  }

  runApp(const NuntiusApp());
}
