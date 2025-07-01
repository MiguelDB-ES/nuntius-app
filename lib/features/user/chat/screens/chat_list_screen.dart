// lib/features/user/chat/screens/chat_list_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iniciar novo chat (funcionalidade a ser implementada).')),
              );
              // TODO: Implementar navegação para tela de seleção de contato para novo chat
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Simulação de 5 conversas
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                child: Text('U${index + 1}', style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
              title: Text('Conversa com Usuário ${index + 1}', style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text('Última mensagem: Olá, tudo bem? (simulado)', style: Theme.of(context).textTheme.bodySmall),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Ao tocar, navega para a tela de chat com o ID do chat/usuário
                // O argumento é o nome do contato para a tela de chat
                Navigator.of(context).pushNamed(AppRoutes.chatScreen, arguments: 'Usuário ${index + 1}');
              },
            ),
          );
        },
      ),
    );
  }
}
