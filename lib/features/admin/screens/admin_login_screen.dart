import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login do Administrador')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Acesso Restrito', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 24),
            TextField(decoration: const InputDecoration(labelText: 'Usuário Admin')),
            SizedBox(height: 16),
            TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Senha Admin')),
            SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: const Text('Entrar como Admin')),
          ],
        ),
      ),
    );
  }
}