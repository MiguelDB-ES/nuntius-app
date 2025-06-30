// lib/features/user/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.userMenuOverlay),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o ícone de pesquisa e o texto
          mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço necessário
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.searchScreen),
            ),
            Text(
              'Nuntius',
              style: Theme.of(context).appBarTheme.titleTextStyle, // Usa o estilo de título da AppBar
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificações em breve!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Simula um feed infinito de notícias. Futuramente, virá de um repositório.
        itemBuilder: (context, index) {
          // Cada item do feed é um PostCard
          return PostCard(
            index: index,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.newsDetail),
            onProfileTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar para Perfil do Autor/Fórum')),
              );
              // Futuramente, navegar para o perfil do autor
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Garante que todos os ícones sejam exibidos
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodySmall?.color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Fóruns'), // Megafone
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Criar'), // Símbolo de adição
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chats'), // Balão de fala
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Lógica de navegação da barra inferior
          switch (index) {
            case 0:
              // Já está na Home
              break;
            case 1:
              Navigator.of(context).pushNamed(AppRoutes.forumList);
              break;
            case 2:
              Navigator.of(context).pushNamed(AppRoutes.createPost);
              break;
            case 3:
              Navigator.of(context).pushNamed(AppRoutes.chatList);
              break;
            case 4:
              Navigator.of(context).pushNamed(AppRoutes.userProfile);
              break;
          }
        },
      ),
    );
  }
}

// Widget separado para representar um card de postagem no feed
class PostCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final VoidCallback onProfileTap;

  const PostCard({
    super.key,
    required this.index,
    required this.onTap,
    required this.onProfileTap,
  });

  // Widget auxiliar para construir botões de reação
  Widget _buildReactionButton(BuildContext context, IconData icon, String label, int count) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label: $count')),
        );
        // Futuramente, implementar a lógica de reação (ex: curtir, comentar)
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).textTheme.bodyMedium?.color),
            const SizedBox(width: 4),
            Text('$count', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 4),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Icon(Icons.person, size: 24, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Autor da Postagem ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Data: 10/06/2024 - Hora: 15:${10 + index}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Opções da postagem (ex: denunciar, salvar)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opções da Postagem')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Notícia ${index + 1}: Título da Notícia Impactante sobre a Comunidade',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              // Placeholder para imagem da notícia
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://placehold.co/600x300/${(0xFF000000 + (index * 1000000)).toRadixString(16).substring(2, 8)}/${(0xFFFFFFFF - (index * 1000000)).toRadixString(16).substring(2, 8)}?text=Noticia%20${index + 1}',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Theme.of(context).cardColor,
                    child: Center(
                      child: Text(
                        'Erro ao carregar imagem',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Breve descrição da notícia. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Esta é uma prévia do conteúdo, clique para ler mais...',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildReactionButton(context, Icons.favorite_border, 'Curtir', 123 + index),
                  _buildReactionButton(context, Icons.comment_outlined, 'Comentar', 45 + index),
                  _buildReactionButton(context, Icons.share_outlined, 'Compartilhar', 10 + index),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onProfileTap,
                  child: const Text('Ver Perfil do Autor/Fórum'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
