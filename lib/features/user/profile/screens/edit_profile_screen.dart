// lib/features/user/profile/screens/edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para FilteringTextInputFormatter
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nuntius/core/session/session_manager.dart'; // Importe o SessionManager
import 'package:nuntius/data/repositories/auth_repository.dart'; // Importe o AuthRepository
import 'package:nuntius/models/user_model.dart'; // Importe o UserModel

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();
  UserModel? _currentUser; // Para armazenar o usuário atual

  // Formatador para CPF: XXX.XXX.XXX-XX
  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Carrega os dados do usuário logado para preencher os campos
  void _loadUserData() {
    _currentUser = SessionManager().currentUser;
    if (_currentUser != null) {
      _fullNameController.text = _currentUser!.fullName;
      _emailController.text = _currentUser!.email;
      _cpfController.text = _currentUser!.cpf ?? '';
      _dateOfBirthController.text = _currentUser!.dateOfBirth ?? '';
      _addressController.text = _currentUser!.address ?? '';
    }
  }

  // Função para selecionar a data de nascimento
  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  // Função para salvar as alterações do perfil
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Usuário não encontrado para atualização.')),
        );
        return;
      }

      // Cria um novo UserModel com os dados atualizados
      final updatedUser = UserModel(
        id: _currentUser!.id, // Mantenha o ID do usuário existente
        fullName: _fullNameController.text,
        email: _emailController.text,
        cpf: _cpfController.text.isEmpty ? null : _cpfController.text,
        passwordHash: _currentUser!.passwordHash, // A senha não é alterada aqui
        dateOfBirth: _dateOfBirthController.text.isEmpty ? null : _dateOfBirthController.text,
        address: _addressController.text.isEmpty ? null : _addressController.text,
        latitude: _currentUser!.latitude, // Mantenha a latitude existente
        longitude: _currentUser!.longitude, // Mantenha a longitude existente
        userType: _currentUser!.userType, // Mantenha o tipo de usuário existente
        profilePictureUrl: _currentUser!.profilePictureUrl, // Mantenha a URL da foto de perfil existente
        registrationDate: _currentUser!.registrationDate, // Mantenha a data de cadastro existente
        isActive: _currentUser!.isActive, // Mantenha o status de ativo existente
      );

      try {
        final rowsAffected = await _authRepository.updateUser(updatedUser);

        if (!mounted) return;

        if (rowsAffected > 0) {
          // Atualiza o usuário na sessão em memória
          SessionManager().setCurrentUser(updatedUser);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil atualizado com sucesso!')),
          );
          Navigator.of(context).pop(); // Volta para a tela de perfil
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Falha ao atualizar o perfil. Tente novamente.')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar perfil: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome completo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor, insira um email válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF (Opcional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfFormatter],
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 14) {
                      return 'Por favor, insira um CPF válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento (Opcional)',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => _selectDateOfBirth(context),
                    ),
                  ),
                  readOnly: true, // Impede a edição manual
                  onTap: () => _selectDateOfBirth(context),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço (Opcional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Salvar Alterações',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
