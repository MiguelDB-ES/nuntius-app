// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/repositories/auth_repository.dart'; // Importe o repositório

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
      final user = await _authRepository.loginUser(
        _emailCpfController.text,
        _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login realizado com sucesso! Bem-vindo, ${user.fullName}')),
        );
        // Navegar para a home do usuário
        Navigator.of(context).pushReplacementNamed(AppRoutes.userHome);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciais inválidas. Verifique seu e-mail/CPF e senha.')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailCpfController,
                decoration: const InputDecoration(labelText: 'E-mail ou CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail ou CPF.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
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
                    // Implementar navegação para Esqueci minha senha
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navegar para Esqueci minha senha.')),
                    );
                  },
                  child: const Text('Esqueci minha senha?'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loginUser,
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.register);
                },
                child: const Text('Ainda não tem conta? Registre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
