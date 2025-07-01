import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  // Adiciona o parâmetro nomeado contactName
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contactName)), // Usa o contactName no AppBar
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Para mensagens mais recentes na parte inferior
              itemCount: 5,
              itemBuilder: (context, index) {
                // Simplesmente para demonstração: alternar mensagens como enviadas/recebidas
                bool isMe = index % 2 == 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isMe ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text('Mensagem ${index + 1}', style: TextStyle(color: isMe ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enviar mensagem...',
                suffixIcon: IconButton(icon: const Icon(Icons.send), onPressed: () {}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
