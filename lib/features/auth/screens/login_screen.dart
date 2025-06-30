// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/repositories/auth_repository.dart'; // Importe o repositório
import 'package:nuntius/core/session/session_manager.dart'; // NOVO: Importe o SessionManager

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository(); // Instância do repositório
  final _formKey = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await _authRepository.loginUser(
          _emailCpfController.text,
          _passwordController.text,
        );

        if (!mounted) return; // Verifica se o widget ainda está montado

        if (user != null) {
          // NOVO: Define o usuário na sessão em memória
          SessionManager().setCurrentUser(user);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login realizado com sucesso! Bem-vindo(a), ${user.fullName.split(' ').first}.')),
          );
          // TODO: Implementar a navegação para a home do usuário após o login
          // Exemplo: Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
          Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas ou usuário inativo. Por favor, tente novamente.')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao realizar login: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailCpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Adicione um logo ou imagem aqui se desejar
                // Image.asset('assets/logo.png', height: 100),
                // const SizedBox(height: 48),
                TextFormField(
                  controller: _emailCpfController,
                  decoration: const InputDecoration(
                    labelText: 'Email ou CPF',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email ou CPF.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha.';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implementar navegação para Esqueci minha senha
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Funcionalidade "Esqueci minha senha" a ser implementada.')),
                      );
                    },
                    child: const Text('Esqueci minha senha?'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // Botão de largura total
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Navega para a tela de registro
                    Navigator.of(context).pushNamed(AppRoutes.register);
                  },
                  child: const Text('Ainda não tem conta? Registre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
