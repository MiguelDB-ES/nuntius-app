// lib/features/user/profile/screens/user_menu_overlay.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/services/user_service.dart'; // NOVO: Importe o UserService
import 'package:nuntius/models/user_model.dart'; // NOVO: Importe o UserModel

class UserMenuOverlay extends StatelessWidget {
  const UserMenuOverlay({super.key});

  // Função de logout real
  void _logout(BuildContext context) async {
    await UserService().logout(); // Limpa os dados do usuário
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você saiu da sua conta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o usuário atual do UserService
    final UserModel? currentUser = UserService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Informações do usuário no topo do menu
          if (currentUser != null)
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  currentUser.profilePictureUrl ?? 'https://placehold.co/60x60/FFC107/FFFFFF?text=NU',
                ),
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint('Erro ao carregar imagem de perfil no menu: $exception');
                },
              ),
              title: Text(
                currentUser.fullName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Ver Perfil',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueAccent),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Fecha o menu
                Navigator.of(context).pushNamed(AppRoutes.userProfile);
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o menu
              Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
            },
          ),
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('Fóruns'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o menu
              Navigator.of(context).pushNamed(AppRoutes.forumList);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chats'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o menu
              Navigator.of(context).pushNamed(AppRoutes.chatList);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Criar Postagem'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o menu
              Navigator.of(context).pushNamed(AppRoutes.createPost);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o menu
              Navigator.of(context).pushNamed(AppRoutes.userSettings);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair da Conta'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) { // Use um contexto diferente para o dialog
                  return AlertDialog(
                    title: const Text('Sair da Conta'),
                    content: const Text('Tem certeza que deseja sair da sua conta?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Fecha o AlertDialog
                        },
                      ),
                      TextButton(
                        child: const Text('Sair', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Fecha o AlertDialog
                          _logout(context); // Chama a função de logout real
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
