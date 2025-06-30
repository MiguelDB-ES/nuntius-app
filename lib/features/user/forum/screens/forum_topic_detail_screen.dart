// lib/features/user/forum/screens/forum_topic_detail_screen.dart
import 'package:flutter/material.dart';

// Modelo de dados para um tópico de fórum
class ForumTopic {
  final String id;
  final String title;
  final String content;
  final String author;
  final String date;
  final int views;
  final int likes;
  final List<Comment> comments;

  ForumTopic({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    this.views = 0,
    this.likes = 0,
    this.comments = const [],
  });
}

// Modelo de dados para um comentário
class Comment {
  final String id;
  final String author;
  final String content;
  final String date;

  Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.date,
  });
}

class ForumTopicDetailScreen extends StatefulWidget {
  final String? topicId; // Recebe o ID do tópico como argumento

  const ForumTopicDetailScreen({super.key, this.topicId});

  @override
  State<ForumTopicDetailScreen> createState() => _ForumTopicDetailScreenState();
}

class _ForumTopicDetailScreenState extends State<ForumTopicDetailScreen> {
  ForumTopic? _currentTopic; // O tópico atualmente exibido
  bool _isLoading = true; // Estado para controlar o carregamento
  String? _errorMessage; // Para exibir mensagens de erro
  final TextEditingController _commentController = TextEditingController(); // Controlador para o campo de comentário

  @override
  void initState() {
    super.initState();
    _loadTopicDetails(); // Inicia o carregamento dos detalhes do tópico
  }

  // Simula o carregamento dos detalhes do tópico e seus comentários
  Future<void> _loadTopicDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simula um atraso de rede
      await Future.delayed(const Duration(seconds: 2));

      // Dados de exemplo para um tópico (substitua pela lógica de busca real)
      // Aqui, você usaria widget.topicId para buscar o tópico correto do seu DB.
      final String topicId = widget.topicId ?? 'default_topic_id'; // Usa o ID passado ou um padrão

      // Simula a busca de um tópico com base no ID
      ForumTopic? fetchedTopic;
      if (topicId == '1') { // Exemplo: Tópico de Desenvolvimento Web
        fetchedTopic = ForumTopic(
          id: '1',
          title: 'Melhores Frameworks Front-end em 2024',
          content: 'Qual a opinião de vocês sobre os frameworks mais promissores para desenvolvimento web front-end neste ano? React, Vue, Angular, Svelte ou algo novo?',
          author: 'DevMaster',
          date: '15/06/2024',
          views: 1250,
          likes: 85,
          comments: [
            Comment(id: 'c1', author: 'User123', content: 'Ainda aposto no React pela sua comunidade e ecossistema.', date: '15/06/2024 10:30'),
            Comment(id: 'c2', author: 'CodeGuru', content: 'Svelte tem ganhado muito espaço pela sua performance.', date: '15/06/2024 11:00'),
            Comment(id: 'c3', author: 'FlutterFan', content: 'E o Flutter Web? Alguém usando em produção?', date: '15/06/2024 12:15'),
          ],
        );
      } else if (topicId == '2') { // Exemplo: Tópico de Culinária Caseira
         fetchedTopic = ForumTopic(
          id: '2',
          title: 'Dicas para um bolo perfeito!',
          content: 'Compartilhem suas melhores dicas para fazer um bolo fofinho e delicioso. Qual o segredo?',
          author: 'ChefAmador',
          date: '20/06/2024',
          views: 800,
          likes: 60,
          comments: [
            Comment(id: 'c4', author: 'BoloLover', content: 'Usar ingredientes em temperatura ambiente faz toda a diferença!', date: '20/06/2024 14:00'),
            Comment(id: 'c5', author: 'Doceira', content: 'Não abrir o forno antes da hora é crucial.', date: '20/06/2024 14:45'),
          ],
        );
      } else {
        // Tópico não encontrado ou ID inválido
        fetchedTopic = null;
      }

      if (mounted) {
        setState(() {
          _currentTopic = fetchedTopic;
          _isLoading = false;
          if (_currentTopic == null) {
            _errorMessage = 'Tópico não encontrado.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erro ao carregar o tópico: $e';
          _isLoading = false;
        });
      }
      debugPrint('Erro ao carregar o tópico: $e');
    }
  }

  // Função para adicionar um novo comentário (simulado)
  void _addComment() {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite um comentário.')),
      );
      return;
    }

    // Simula a adição de um comentário
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID único
      author: 'Você', // Em um app real, seria o nome do usuário logado
      content: _commentController.text.trim(),
      date: 'Agora', // Em um app real, seria a data e hora formatada
    );

    setState(() {
      _currentTopic!.comments.add(newComment); // Adiciona o novo comentário à lista
      _commentController.clear(); // Limpa o campo de texto
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comentário adicionado!')),
    );
    // TODO: Em um app real, você enviaria este comentário para o backend/DB
  }

  @override
  void dispose() {
    _commentController.dispose(); // Libera o controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTopic?.title ?? 'Tópico do Fórum'), // Título dinâmico
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
              : _currentTopic == null
                  ? Center(
                      child: Text(
                        'Tópico não encontrado.',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _currentTopic!.title,
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Criado por: ${_currentTopic!.author} - ${_currentTopic!.date}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _currentTopic!.content,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildActionChip(
                                      context,
                                      Icons.visibility_outlined,
                                      'Visualizações',
                                      _currentTopic!.views,
                                    ),
                                    _buildActionChip(
                                      context,
                                      Icons.thumb_up_alt_outlined,
                                      'Curtidas',
                                      _currentTopic!.likes,
                                    ),
                                    // Adicionar botão de compartilhamento se necessário
                                    ActionChip(
                                      avatar: Icon(Icons.share, color: Theme.of(context).colorScheme.onSurface),
                                      label: Text('Compartilhar', style: Theme.of(context).textTheme.bodySmall),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Compartilhar tópico!')),
                                        );
                                        // TODO: Implementar funcionalidade de compartilhamento
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text('Comentários (${_currentTopic!.comments.length})', style: Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 8),
                                // Lista de comentários
                                _currentTopic!.comments.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 16.0),
                                        child: Center(
                                          child: Text(
                                            'Nenhum comentário ainda. Seja o primeiro a comentar!',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true, // Importante para ListView aninhada em Column/SingleChildScrollView
                                        physics: const NeverScrollableScrollPhysics(), // Desabilita o scroll da ListView interna
                                        itemCount: _currentTopic!.comments.length,
                                        itemBuilder: (context, index) {
                                          final comment = _currentTopic!.comments[index];
                                          return Card(
                                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        comment.author,
                                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        comment.date,
                                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    comment.content,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                        // Área para adicionar novo comentário
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    labelText: 'Adicionar um comentário...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                  ),
                                  maxLines: null, // Permite múltiplas linhas
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                onPressed: _addComment,
                                mini: true, // Botão menor
                                child: const Icon(Icons.send),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }

  // Widget auxiliar para exibir informações como visualizações e curtidas
  Widget _buildActionChip(BuildContext context, IconData icon, String label, int count) {
    return ActionChip(
      avatar: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      label: Text('$count $label', style: Theme.of(context).textTheme.bodySmall),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label: $count')),
        );
      },
    );
  }
}
