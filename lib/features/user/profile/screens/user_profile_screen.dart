// lib/features/user/profile/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/services/user_service.dart';
import 'package:nuntius/models/user_model.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserModel? _user; // O usuário será carregado aqui

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // Carrega os dados do usuário do UserService
  Future<void> _loadUser() async {
    final user = UserService().currentUser;
    if (mounted) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se o usuário ainda não foi carregado, exibe um indicador de carregamento
    if (_user == null) {
      return Scaffold( // REMOVIDO 'const' daqui
        appBar: AppBar(title: const Text('Meu Perfil')), // Adicionado 'const' ao Text para otimização, mas não é obrigatório agora
        body: const Center(child: CircularProgressIndicator()), // Mantido 'const' aqui se Center e CircularProgressIndicator forem const
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // Navega para a tela de edição e recarrega o perfil ao retornar
              await Navigator.of(context).pushNamed(AppRoutes.editProfile);
              _loadUser(); // Recarrega os dados após a edição
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.userSettings);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Seção do Cabeçalho do Perfil
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      _user!.profilePictureUrl ?? 'https://placehold.co/120x120/FFC107/FFFFFF?text=NU', // Fallback para URL de imagem
                    ),
                    onBackgroundImageError: (exception, stackTrace) {
                      debugPrint('Erro ao carregar imagem de perfil: $exception');
                      // Pode exibir um ícone de erro ou imagem padrão
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user!.fullName, // Nome do usuário real
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _user!.email, // Email do usuário real
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn(context, 'Postagens', '150'), // Estes ainda são fictícios
                      _buildStatColumn(context, 'Seguidores', '2.5K'),
                      _buildStatColumn(context, 'Seguindo', '300'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Seção de Postagens do Usuário (Exemplo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minhas Postagens',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5, // Exemplo de 5 postagens
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Título da Minha Postagem ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Conteúdo breve da postagem. Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Publicado em: 15/06/2024',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
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
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para exibir estatísticas do perfil
  Widget _buildStatColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
