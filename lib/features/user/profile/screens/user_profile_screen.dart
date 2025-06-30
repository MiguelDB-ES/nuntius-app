// lib/features/user/profile/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/core/session/session_manager.dart'; // NOVO: Importe o SessionManager
import 'package:nuntius/data/repositories/auth_repository.dart'; // NOVO: Importe o AuthRepository

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthRepository _authRepository = AuthRepository();

  // Função para lidar com o logout
  Future<void> _logout() async {
    await _authRepository.clearUserSession(); // Limpa a sessão no SharedPreferences
    SessionManager().clearCurrentUser(); // Limpa a sessão em memória
    if (mounted) {
      // Redireciona para a tela de login ou welcome, removendo todas as rotas anteriores
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = SessionManager().currentUser; // Obtém o usuário logado

    if (currentUser == null) {
      // Caso não haja usuário logado (o que não deveria acontecer se a SplashScreen funcionar corretamente)
      return Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: const Center(
          child: Text('Nenhum usuário logado.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.editProfile);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Chama a função de logout
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem de Perfil
            CircleAvatar(
              radius: 60,
              backgroundImage: currentUser.profilePictureUrl != null && currentUser.profilePictureUrl!.isNotEmpty
                  ? NetworkImage(currentUser.profilePictureUrl!) as ImageProvider
                  : const AssetImage('assets/images/default_profile.png'), // Imagem padrão
              child: currentUser.profilePictureUrl == null || currentUser.profilePictureUrl!.isEmpty
                  ? const Icon(Icons.person, size: 60, color: Colors.white70)
                  : null,
            ),
            const SizedBox(height: 16),
            // Nome Completo
            Text(
              currentUser.fullName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              currentUser.email,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Detalhes do Perfil em Cards
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileDetailRow(context, Icons.badge, 'Tipo de Usuário:', currentUser.userType == 'fisica' ? 'Pessoa Física' : 'Administrador'),
                    if (currentUser.cpf != null && currentUser.cpf!.isNotEmpty)
                      _buildProfileDetailRow(context, Icons.credit_card, 'CPF:', currentUser.cpf!),
                    if (currentUser.dateOfBirth != null && currentUser.dateOfBirth!.isNotEmpty)
                      _buildProfileDetailRow(context, Icons.calendar_today, 'Data de Nascimento:', currentUser.dateOfBirth!),
                    if (currentUser.address != null && currentUser.address!.isNotEmpty)
                      _buildProfileDetailRow(context, Icons.location_on, 'Endereço:', currentUser.address!),
                    _buildProfileDetailRow(context, Icons.app_registration, 'Data de Cadastro:', currentUser.registrationDate),
                    _buildProfileDetailRow(context, Icons.check_circle_outline, 'Status:', currentUser.isActive ? 'Ativo' : 'Inativo'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Outras ações ou informações podem ser adicionadas aqui
            ElevatedButton(
              onPressed: () {
                // Exemplo de outra ação
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configurações do perfil...')),
                );
              },
              child: const Text('Configurações'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir linhas de detalhes do perfil
  Widget _buildProfileDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
