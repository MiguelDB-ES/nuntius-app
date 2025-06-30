import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(radius: 60, child: Icon(Icons.person, size: 80)),
            SizedBox(height: 20),
            Text('Nome do Usuário', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text('usuario@email.com', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.editProfile), child: const Text('Editar Perfil')),
            SizedBox(height: 16),
            ListTile(leading: Icon(Icons.article), title: Text('Minhas Denúncias'), onTap: () {}),
            ListTile(leading: Icon(Icons.bookmark), title: Text('Notícias que Sigo'), onTap: () {}),
            ListTile(leading: Icon(Icons.forum), title: Text('Tópicos do Fórum que Participo'), onTap: () {}),
          ],
        ),
      ),
    );
  }
}