// lib/features/user/profile/screens/user_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/services/user_service.dart'; // NOVO: Importe o UserService

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _privateAccount = false;
  String _selectedTheme = 'Sistema'; // 'Claro', 'Escuro', 'Sistema'

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Carrega as configurações do UserService
  Future<void> _loadSettings() async {
    _notificationsEnabled = await UserService().getNotificationsEnabled();
    _privateAccount = await UserService().getPrivateAccount();
    _selectedTheme = await UserService().getSelectedTheme();
    if (mounted) {
      setState(() {});
    }
  }

  // Função de logout real
  void _logout() async {
    await UserService().logout(); // Limpa os dados do usuário
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você saiu da sua conta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Geral',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SwitchListTile(
            title: const Text('Ativar Notificações'),
            value: _notificationsEnabled,
            onChanged: (bool value) async {
              setState(() {
                _notificationsEnabled = value;
              });
              await UserService().setNotificationsEnabled(value); // Salva a configuração
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notificações ${value ? 'ativadas' : 'desativadas'}')),
                );
              }
            },
          ),
          ListTile(
            title: const Text('Tema do Aplicativo'),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  setState(() {
                    _selectedTheme = newValue;
                  });
                  await UserService().setSelectedTheme(newValue); // Salva a configuração
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tema alterado para: $newValue')),
                    );
                    // TODO: Implementar a lógica real de mudança de tema no MaterialApp
                  }
                }
              },
              items: <String>['Sistema', 'Claro', 'Escuro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          Text(
            'Privacidade e Segurança',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SwitchListTile(
            title: const Text('Conta Privada'),
            value: _privateAccount,
            onChanged: (bool value) async {
              setState(() {
                _privateAccount = value;
              });
              await UserService().setPrivateAccount(value); // Salva a configuração
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Conta ${value ? 'privada' : 'pública'}')),
                );
              }
            },
          ),
          ListTile(
            title: const Text('Alterar Senha'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar para tela de alteração de senha.')),
              );
              // TODO: Implementar navegação para tela de alteração de senha
            },
          ),
          ListTile(
            title: const Text('Gerenciar Dispositivos Conectados'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar para gerenciamento de dispositivos.')),
              );
              // TODO: Implementar navegação para gerenciamento de dispositivos
            },
          ),
          const Divider(),
          Text(
            'Outros',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            title: const Text('Sobre o Nuntius'),
            trailing: const Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Nuntius',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Nuntius. Todos os direitos reservados.',
                children: [
                  Text('Nuntius é um aplicativo de rede social e notícias para a comunidade.'),
                ],
              );
            },
          ),
          ListTile(
            title: const Text('Termos de Serviço e Política de Privacidade'),
            trailing: const Icon(Icons.description),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar para termos e política.')),
              );
              // TODO: Abrir URL ou navegar para tela de termos
            },
          ),
          ListTile(
            title: const Text('Sair da Conta'),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sair da Conta'),
                    content: const Text('Tem certeza que deseja sair da sua conta?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sair', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o AlertDialog
                          _logout(); // Chama a função de logout real
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
