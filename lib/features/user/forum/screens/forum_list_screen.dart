import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class ForumListScreen extends StatelessWidget {
  const ForumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fóruns'),
        centerTitle: true, // Centraliza o título
      ),
      body: ListView.builder(
        itemCount: 5, // Exemplo: 5 fóruns
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4, // Adiciona uma leve sombra
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Cantos arredondados
            ),
            child: InkWell( // Torna o cartão clicável
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.forumTopicDetail),
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nicho de Fórum ${index + 1}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descrição breve do nicho de fórum e seus tópicos relacionados. Participe da discussão!',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tópicos: ${10 + index}', // Exemplo de número de tópicos
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).hintColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidade "Criar Novo Fórum" a ser implementada.')),
          );
          // TODO: Implementar navegação para a tela de criação de novo fórum
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Fórum'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
