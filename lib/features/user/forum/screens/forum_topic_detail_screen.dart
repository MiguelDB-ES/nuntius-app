import 'package:flutter/material.dart';

class ForumTopicDetailScreen extends StatelessWidget {
  const ForumTopicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tópico do Fórum')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título do Tópico de Discussão', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text('Criado por: Nome do Usuário - 10/06/2024', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 16),
            Text('Conteúdo da discussão. Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 24),
            Text('Comentários', style: Theme.of(context).textTheme.titleLarge),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Comentário do Usuário ${index + 1}'), subtitle: Text('Este é um comentário de exemplo.'));
                },
              ),
            ),
            TextField(decoration: const InputDecoration(labelText: 'Adicionar comentário...', suffixIcon: Icon(Icons.send))),
          ],
        ),
      ),
    );
  }
}