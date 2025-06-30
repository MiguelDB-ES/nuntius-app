// lib/features/user/forum/screens/forum_list_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

// Modelo de dados simples para uma categoria de fórum
// Este modelo será usado para os dados carregados dinamicamente
class ForumCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon; // Ícone representativo para a categoria
  final int numberOfTopics;
  final int numberOfPosts;

  ForumCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.numberOfTopics = 0,
    this.numberOfPosts = 0,
  });
}

class ForumListScreen extends StatefulWidget {
  const ForumListScreen({super.key});

  @override
  State<ForumListScreen> createState() => _ForumListScreenState();
}

class _ForumListScreenState extends State<ForumListScreen> {
  // Lista de categorias de fórum que será preenchida dinamicamente
  List<ForumCategory> _forumCategories = [];
  bool _isLoading = true; // Estado para controlar o carregamento dos dados
  String? _errorMessage; // Para exibir mensagens de erro

  @override
  void initState() {
    super.initState();
    _loadForumCategories(); // Inicia o carregamento dos fóruns
  }

  // Simula o carregamento de categorias de fórum de um backend/banco de dados
  Future<void> _loadForumCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Limpa qualquer erro anterior
    });

    try {
      // Simula um atraso de rede
      await Future.delayed(const Duration(seconds: 2));

      // Dados de exemplo (remova ou substitua por dados reais do usuário)
      // Estes dados são apenas para demonstração de como a lista seria preenchida
      // quando os usuários começassem a criar fóruns.
      final List<ForumCategory> fetchedCategories = [
        ForumCategory(
          id: '1',
          title: 'Fórum de Desenvolvimento Web',
          description: 'Discussões sobre HTML, CSS, JavaScript, frameworks e mais.',
          icon: Icons.code,
          numberOfTopics: 230,
          numberOfPosts: 3500,
        ),
        ForumCategory(
          id: '2',
          title: 'Fórum de Culinária Caseira',
          description: 'Receitas, dicas e truques para cozinheiros amadores e experientes.',
          icon: Icons.restaurant_menu,
          numberOfTopics: 180,
          numberOfPosts: 2100,
        ),
        ForumCategory(
          id: '3',
          title: 'Fórum de Jogos e Gamers',
          description: 'Novidades, análises e discussões sobre seus jogos favoritos.',
          icon: Icons.gamepad,
          numberOfTopics: 300,
          numberOfPosts: 5000,
        ),
        // Adicione mais categorias criadas por usuários aqui
      ];

      if (mounted) {
        setState(() {
          _forumCategories = fetchedCategories;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erro ao carregar fóruns: $e';
          _isLoading = false;
        });
      }
      debugPrint('Erro ao carregar fóruns: $e'); // Para depuração
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fóruns da Comunidade'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Exibe indicador de carregamento
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _forumCategories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.forum_outlined,
                            size: 80,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum fórum criado ainda.',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Seja o primeiro a criar um fórum!',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Funcionalidade de criar novo fórum a ser implementada!')),
                              );
                              // TODO: Navegar para a tela de criação de fórum
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Criar Novo Fórum'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _forumCategories.length,
                      itemBuilder: (context, index) {
                        final category = _forumCategories[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.forumTopicDetail,
                                arguments: category.id, // Passa o ID da categoria
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    category.icon,
                                    size: 40,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.title,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          category.description,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.format_list_bulleted, size: 16, color: Theme.of(context).textTheme.bodySmall?.color),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${category.numberOfTopics} Tópicos',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(Icons.message_outlined, size: 16, color: Theme.of(context).textTheme.bodySmall?.color),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${category.numberOfPosts} Posts',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
      floatingActionButton: _isLoading || _errorMessage != null || _forumCategories.isEmpty
          ? null // Oculta o FAB se estiver carregando, com erro ou vazio (já tem botão no centro)
          : FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidade de criar novo tópico/fórum a ser implementada!')),
                );
                // TODO: Implementar navegação para a tela de criação de novo tópico/fórum
                // Navigator.of(context).pushNamed(AppRoutes.createForumTopic);
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Fórum'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
    );
  }
}
