import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Notícia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título Completo da Notícia', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text('Por: Nome do Autor - 10/06/2024 15:00', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 16),
            Image.network('https://placehold.co/600x300/cccccc/ffffff?text=Noticia+Completa', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 300, color: Colors.grey, child: Center(child: Text('Erro ao carregar imagem')))),
            SizedBox(height: 16),
            Text('Aqui vai o texto completo e detalhado da notícia. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: const Icon(Icons.favorite), onPressed: () {}), // Ícone de curtida
                IconButton(icon: const Icon(Icons.comment), onPressed: () {}), // Ícone de comentário
                IconButton(icon: const Icon(Icons.share), onPressed: () {}), // Ícone de compartilhamento
              ],
            ),
            SizedBox(height: 24),
            Text('Comentários', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            TextField(decoration: const InputDecoration(labelText: 'Adicionar um comentário...', suffixIcon: Icon(Icons.send))),
            // Adicionar lista de comentários aqui
            ListTile(title: Text('Usuário 1'), subtitle: Text('Ótima postagem!')),
            ListTile(title: Text('Usuário 2'), subtitle: Text('Muito relevante para a comunidade.')),
          ],
        ),
      ),
    );
  }
}