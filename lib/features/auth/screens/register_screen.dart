// lib/features/auth/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:nuntius/core/routes/app_routes.dart';
import 'package:nuntius/data/repositories/auth_repository.dart';
import 'package:nuntius/models/user_model.dart';
import 'package:intl/intl.dart';
// Importa o pacote de máscara de input
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;
  final AuthRepository _authRepository = AuthRepository();

  // Formatador para CPF: XXX.XXX.XXX-XX
  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Formatador para Data de Nascimento: DD/MM/AAAA
  final MaskTextInputFormatter _dateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você deve concordar com os Termos de Uso e Política de Privacidade.')),
        );
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem.')),
        );
        return;
      }

      // Remover a máscara do CPF e da Data antes de salvar no UserModel,
      // pois o DB espera a string pura ou formatada (YYYY-MM-DD para data).
      String? rawCpf = _cpfFormatter.getUnmaskedText().isNotEmpty ? _cpfFormatter.getUnmaskedText() : null;
      String? rawDateOfBirth;
      if (_dateOfBirthController.text.isNotEmpty) {
        try {
          // Converte DD/MM/YYYY para YYYY-MM-DD para salvar no banco
          DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(_dateOfBirthController.text);
          rawDateOfBirth = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          // Em caso de erro na data, trata como nulo ou exibe um erro
          rawDateOfBirth = null;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Formato de Data de Nascimento inválido. Use DD/MM/AAAA.')),
            );
          }
          return; // Interrompe o registro se a data for inválida
        }
      } else {
        rawDateOfBirth = null;
      }


      final user = UserModel(
        fullName: _fullNameController.text,
        email: _emailController.text,
        cpf: rawCpf,
        passwordHash: _passwordController.text,
        dateOfBirth: rawDateOfBirth,
        address: null, // Endereço nulo por enquanto
        latitude: null,
        longitude: null,
        userType: 'cidadao',
        profilePictureUrl: null,
        registrationDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        isActive: true,
      );

      try {
        final userId = await _authRepository.registerUser(user);
        if (userId > 0) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')),
          );
          Navigator.of(context).pop();
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao cadastrar usuário.')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
        print('Erro detalhado no registro: $e');
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar-se')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nome Completo'),
                  // Validação aprimorada para nome (apenas letras, espaços e alguns caracteres acentuados)
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome completo.';
                    }
                    if (!RegExp(r'^[a-zA-Z\u00C0-\u00FF\s\.\-]+$').hasMatch(value)) {
                      return 'Nome inválido. Use apenas letras e espaços.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'E-mail inválido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(labelText: 'CPF (opcional)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfFormatter], // Aplica a máscara de CPF
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 14 && _cpfFormatter.getUnmaskedText().length < 11) {
                      return 'CPF incompleto.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: const InputDecoration(labelText: 'Data de Nascimento (DD/MM/AAAA)'),
                  keyboardType: TextInputType.number, // Tipo numérico para facilitar a máscara
                  inputFormatters: [_dateFormatter], // Aplica a máscara de data
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value.length < 10) return 'Data incompleta.';
                      // Validação de formato básico (DD/MM/AAAA)
                      if (!RegExp(r'^\d{2}\/\d{2}\/\d{4}$').hasMatch(value)) {
                        return 'Formato de data inválido (DD/MM/AAAA).';
                      }
                      // Adicione validação de data real (ex: dia/mês/ano válidos) se necessário
                      // Exemplo de validação simples de data:
                      try {
                        DateFormat('dd/MM/yyyy').parseStrict(value);
                      } catch (e) {
                        return 'Data inválida.';
                      }
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
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }
                    // Validação de segurança básica da senha (pelo menos uma letra, um número, um caractere especial)
                    if (!RegExp(r'(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?]).*$').hasMatch(value)) {
                      return 'A senha deve conter letras, números e símbolos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme sua senha.';
                    }
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text('Eu concordo com os Termos de Uso e Política de Privacidade.'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
