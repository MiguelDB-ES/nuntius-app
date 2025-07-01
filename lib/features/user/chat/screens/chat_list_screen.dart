import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          final String contactName = 'Conversa com Usuário ${index + 1}';
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text('U${index + 1}')),
              title: Text(contactName),
              subtitle: const Text('Última mensagem: Olá, tudo bem?'),
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.chatScreen,
                arguments: contactName, // Passa o contactName como argumento
              ),
            ),
          );
        },
      ),
    );
  }
}
