// lib/features/user/news/screens/news_detail_screen.dart
import 'package:flutter/material.dart';

// Classe de modelo simples para uma notícia (para dados de exemplo)
class NewsArticle {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;
  final int likes;
  final int commentsCount;
  final int shares;
  final List<Comment> comments;

  NewsArticle({
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.content,
    this.likes = 0,
    this.commentsCount = 0,
    this.shares = 0,
    this.comments = const [],
  });
}

// Classe de modelo simples para um comentário (para dados de exemplo)
class Comment {
  final String author;
  final String text;
  final String date;

  Comment({
    required this.author,
    required this.text,
    required this.date,
  });
}

class NewsDetailScreen extends StatefulWidget {
  // O ID da notícia pode ser passado para buscar dados reais
  final String? newsId;

  const NewsDetailScreen({super.key, this.newsId});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late NewsArticle _currentNews;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carrega dados da notícia. Em um app real, você faria uma chamada de API aqui.
    _currentNews = _loadNewsArticle();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Função para simular o carregamento de uma notícia
  NewsArticle _loadNewsArticle() {
    return NewsArticle(
      title: 'Impacto da Nova Tecnologia na Comunidade Local: Uma Análise Aprofundada',
      author: 'Equipe Nuntius',
      date: '10 de Junho de 2024, 15:30',
      imageUrl: 'https://placehold.co/600x400/FF0000/FFFFFF?text=Noticia%20Completa', // Placeholder
      content: '''
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

        A nova tecnologia, cujo nome ainda não foi revelado, promete revolucionar a forma como as comunidades interagem e acessam informações. 
        Especialistas apontam que a implementação trará benefícios significativos para a educação, saúde e economia local. 
        No entanto, desafios como a infraestrutura e a capacitação da população precisarão ser superados para garantir uma transição suave e inclusiva.

        Muitos moradores já expressaram entusiasmo com a iniciativa, esperando que ela melhore a qualidade de vida e crie novas oportunidades. 
        Reuniões comunitárias estão sendo agendadas para discutir os próximos passos e coletar feedback dos cidadãos. 
        A transparência no processo será crucial para o sucesso a longo prazo do projeto.

        Continuaremos acompanhando de perto o desenvolvimento e traremos todas as atualizações.
      ''',
      likes: 123,
      commentsCount: 5,
      shares: 10,
      comments: [
        Comment(author: 'Usuário 1', text: 'Ótima postagem! Muito relevante.', date: '10/06/2024 16:00'),
        Comment(author: 'Usuário 2', text: 'Concordo plenamente. Precisamos de mais discussões sobre isso.', date: '10/06/2024 16:15'),
        Comment(author: 'Usuário 3', text: 'Que legal! Mal posso esperar para ver os resultados.', date: '10/06/2024 16:30'),
      ],
    );
  }

  // Função para adicionar um novo comentário (simulado)
  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _currentNews.comments.add(
          Comment(
            author: 'Você', // Em um app real, seria o nome do usuário logado
            text: _commentController.text,
            date: 'Agora', // Data e hora reais
          ),
        );
        _commentController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comentário adicionado!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Notícia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentNews.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Por ${_currentNews.author}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              _currentNews.date,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                _currentNews.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
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
            const SizedBox(height: 16),
            Text(
              _currentNews.content,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildReactionButton(context, Icons.favorite_border, 'Curtir', _currentNews.likes, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Você curtiu esta notícia!')),
                  );
                  // Lógica para curtir (incrementar contador, enviar para backend)
                }),
                _buildReactionButton(context, Icons.comment_outlined, 'Comentar', _currentNews.commentsCount, () {
                  // Focar no campo de comentário
                  FocusScope.of(context).requestFocus(_commentFocusNode);
                }),
                _buildReactionButton(context, Icons.share_outlined, 'Compartilhar', _currentNews.shares, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notícia compartilhada!')),
                  );
                  // Lógica para compartilhar
                }),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Comentários (${_currentNews.comments.length})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              focusNode: _commentFocusNode, // Atribui o FocusNode
              decoration: InputDecoration(
                labelText: 'Adicionar um comentário...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
              onSubmitted: (value) => _addComment(), // Permite adicionar comentário ao pressionar Enter
            ),
            const SizedBox(height: 16),
            // Lista de comentários
            _currentNews.comments.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Nenhum comentário ainda. Seja o primeiro a comentar!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true, // Importante para ListView dentro de SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(), // Desabilita o scroll da lista interna
                    itemCount: _currentNews.comments.length,
                    itemBuilder: (context, index) {
                      final comment = _currentNews.comments[index];
                      return CommentTile(comment: comment);
                    },
                  ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Volta para a tela anterior
                },
                child: const Text('Voltar para o Feed'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FocusNode para o campo de comentário
  final FocusNode _commentFocusNode = FocusNode();

  // Widget auxiliar para construir botões de reação
  Widget _buildReactionButton(BuildContext context, IconData icon, String label, int count, VoidCallback onPressed) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
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
}

// Widget separado para exibir um único comentário
class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  comment.author,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  comment.date,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              comment.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
