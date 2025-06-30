// lib/features/auth/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para FilteringTextInputFormatter
import 'package:nuntius/core/routes/app_routes.dart'; // Mantenha, pois ele faz a navegação para login
import 'package:nuntius/data/repositories/auth_repository.dart';
import 'package:nuntius/models/user_model.dart';
import 'package:intl/intl.dart';
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

      String? formattedDateOfBirth;
      if (_dateOfBirthController.text.isNotEmpty) {
        try {
          final parsedDate = DateFormat('dd/MM/yyyy').parseStrict(_dateOfBirthController.text);
          formattedDateOfBirth = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          debugPrint('Erro de formatação de data: $e');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Formato de Data de Nascimento inválido. Use DD/MM/AAAA.')),
          );
          return;
        }
      }

      final user = UserModel(
        fullName: _fullNameController.text,
        email: _emailController.text,
        cpf: _cpfController.text.isNotEmpty ? _cpfFormatter.getUnmaskedText() : null,
        passwordHash: _passwordController.text,
        dateOfBirth: formattedDateOfBirth,
        address: null, // Endereço não coletado nesta tela
        latitude: null,
        longitude: null,
        userType: 'fisica', // Definido como 'fisica' diretamente e não é alterável
        profilePictureUrl: null, // NULO no registro inicial, será editado depois
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
          // Volta para a tela de login após o registro
          Navigator.of(context).pop(); 
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao cadastrar usuário. Verifique se o e-mail ou CPF já estão em uso.')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
        );
        debugPrint('Erro detalhado no registro: $e');
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nome Completo'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z\u00C0-\u00FF\s\-']+$")),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome completo.';
                    }
                    if (!RegExp(r"^[a-zA-Z\u00C0-\u00FF\s\-']+$").hasMatch(value)) {
                      return 'Nome inválido. Use apenas letras, espaços, hífens e apóstrofos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(labelText: 'CPF'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CPF.';
                    }
                    // Adicionei a validação para CPF já existir no backend aqui se necessário
                    if (_cpfFormatter.getUnmaskedText().length < 11) {
                      return 'CPF incompleto (requer 11 dígitos).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: const InputDecoration(labelText: 'Data de Nascimento (DD/MM/AAAA)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_dateFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento.';
                    }
                    if (value.length < 10) {
                      return 'Data incompleta.';
                    }
                    if (!RegExp(r'^\d{2}\/\d{2}\/\d{4}$').hasMatch(value)) {
                      return 'Formato de data inválido (DD/MM/AAAA).';
                    }
                    try {
                      DateFormat('dd/MM/yyyy').parseStrict(value);
                    } catch (e) {
                      return 'Data inválida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail.';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+(?:\.[a-zA-Z]+)*$")
                        .hasMatch(value)) {
                      return 'E-mail inválido.';
                    }
                    // Adicionei a validação para e-mail já existir no backend aqui se necessário
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
                    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?]).{6,}$').hasMatch(value)) {
                      return 'A senha deve conter letras, números e símbolos (mín. 6 caracteres).';
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
