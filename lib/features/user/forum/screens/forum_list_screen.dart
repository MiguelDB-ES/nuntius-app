import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';

class ForumListScreen extends StatelessWidget {
  const ForumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fóruns')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Nicho de Fórum ${index + 1}', style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text('Descrição breve do nicho de fórum e seus tópicos relacionados.'),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.forumTopicDetail),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}