// features/user/profile/screens/edit_profile_screen.dart
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(radius: 60, child: Icon(Icons.person, size: 80)),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {
                            // Lógica para alterar foto de perfil
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(decoration: const InputDecoration(labelText: 'Nome Completo')),
              const SizedBox(height: 16),
              TextField(decoration: const InputDecoration(labelText: 'E-mail'), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              TextField(decoration: const InputDecoration(labelText: 'Telefone'), keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              TextField(decoration: const InputDecoration(labelText: 'Endereço')),
              const SizedBox(height: 16),
              TextField(decoration: const InputDecoration(labelText: 'Localização Atual (GPS)')),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Salvar Alterações')),
            ],
          ),
        ),
      ),
    );
  }
}
