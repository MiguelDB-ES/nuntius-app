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
          // Adicione outros ícones de ação se necessário
          // Por exemplo, um ícone de notificação:
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificações')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo(a) ao Nuntius!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Últimas Notícias',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Lista de Notícias de Exemplo
            ListView.builder(
              shrinkWrap: true, // Para que a ListView ocupe apenas o espaço necessário
              physics: const NeverScrollableScrollPhysics(), // Desabilita o scroll da ListView interna
              itemCount: 3, // Exemplo de 3 notícias
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.newsDetail);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://placehold.co/600x200/cccccc/ffffff?text=Noticia+${index + 1}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 200,
                              color: Colors.grey,
                              child: const Center(child: Text('Erro ao carregar imagem')),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Título da Notícia ${index + 1}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Breve descrição da notícia. Lorem ipsum dolor sit amet...',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildReactionButton(context, Icons.thumb_up, 'Curtir', 120),
                              _buildReactionButton(context, Icons.comment, 'Comentar', 35),
                              _buildReactionButton(context, Icons.share, 'Compartilhar', 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Fóruns Ativos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Lista de Fóruns de Exemplo
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // Exemplo de 2 fóruns
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text('Fórum de Discussão ${index + 1}', style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text('Última atividade há 2 horas.'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.forumTopicDetail);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // CORRIGIDO: Adicionado o parâmetro 'items' que é obrigatório
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Fórum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Publicar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0, // Define o item inicial selecionado
        selectedItemColor: Theme.of(context).primaryColor, // Cor do item selecionado
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
        onTap: (index) {
          // Lógica de navegação para a barra inferior
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

  // Widget auxiliar para construir botões de reação
  Widget _buildReactionButton(BuildContext context, IconData icon, String label, int count) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label: $count')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).textTheme.bodyMedium?.color),
            const SizedBox(width: 4),
            Text('$count', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
