import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedTheme = 'Sistema';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          SwitchListTile(title: const Text('Receber Notificações'), value: _notificationsEnabled, onChanged: (bool value) => setState(() => _notificationsEnabled = value)),
          ListTile(
            title: const Text('Tema do Aplicativo'),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              onChanged: (String? newValue) => setState(() => _selectedTheme = newValue!),
              items: <String>['Sistema', 'Claro', 'Escuro'].map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
            ),
          ),
          ListTile(title: const Text('Política de Privacidade'), onTap: () {}),
          ListTile(title: const Text('Termos de Uso'), onTap: () {}),
          ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Sair do Nuntius?'),
                  content: const Text('Você tem certeza que deseja sair?'),
                  actions: <Widget>[
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Não')),
                    TextButton(onPressed: () {Navigator.of(context).pop(); Navigator.of(context).pushReplacementNamed(AppRoutes.login);}, child: const Text('Sim', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}