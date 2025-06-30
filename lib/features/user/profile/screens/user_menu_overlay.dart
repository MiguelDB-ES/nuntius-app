import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class UserMenuOverlay extends StatelessWidget {
  const UserMenuOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 40, color: Colors.white)),
                SizedBox(height: 10),
                Text('Nome do Usuário', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: const Text('Home'), onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.userHome)),
          ListTile(leading: Icon(Icons.campaign), title: const Text('Fóruns'), onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.forumList)),
          ListTile(leading: Icon(Icons.chat_bubble), title: const Text('Chats'), onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.chatList)),
          Divider(),
          ListTile(leading: Icon(Icons.person), title: const Text('Meu Perfil'), onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.userProfile)),
          ListTile(leading: Icon(Icons.settings), title: const Text('Configurações'), onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.userSettings)),
          ListTile(leading: Icon(Icons.logout), title: const Text('Sair'), onTap: () {
            Navigator.of(context).pop(); // Fecha o drawer
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
          }),
        ],
      ),
    );
  }
}