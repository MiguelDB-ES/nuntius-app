import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conteúdo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tipo de Conteúdo'),
                items: const [
                  DropdownMenuItem(value: 'denuncia', child: Text('Denúncia')),
                  DropdownMenuItem(value: 'noticia', child: Text('Notícia')),
                  DropdownMenuItem(value: 'anuncio', child: Text('Anúncio')),
                  DropdownMenuItem(value: 'topico_forum', child: Text('Tópico de Fórum')),
                ],
                onChanged: (value) {
                  // Lógica para mudar formulário conforme o tipo
                },
              ),
              SizedBox(height: 16),
              TextField(decoration: const InputDecoration(labelText: 'Título')),
              SizedBox(height: 16),
              TextField(maxLines: 5, decoration: const InputDecoration(labelText: 'Descrição')),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_file),
                label: const Text('Anexar Mídia'),
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Publicar')),
            ],
          ),
        ),
      ),
    );
  }
}