// lib/models/user_model.dart
class UserModel {
  final int? id; // ID pode ser nulo se o usuário ainda não foi salvo no DB
  final String fullName;
  final String email;
  final String? cpf; // CORREÇÃO: Agora é String? (anulável)
  final String passwordHash;
  final String? dateOfBirth; // Já era String?, mantido
  final String? address; // CORREÇÃO: Agora é String?
  final double? latitude;
  final double? longitude;
  final String userType;
  final String? profilePictureUrl; // Já era String?, mantido
  final String registrationDate;
  final bool isActive;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    this.cpf, // Removido 'required' pois agora é anulável
    required this.passwordHash,
    this.dateOfBirth,
    this.address,
    this.latitude,
    this.longitude,
    required this.userType,
    this.profilePictureUrl,
    required this.registrationDate,
    this.isActive = true,
  });

  // Converte um objeto UserModel para um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_completo': fullName,
      'email': email,
      'cpf': cpf, // Pode ser null aqui
      'senha_hash': passwordHash,
      'data_nascimento': dateOfBirth,
      'endereco': address,
      'latitude': latitude,
      'longitude': longitude,
      'tipo_usuario': userType,
      'url_foto_perfil': profilePictureUrl,
      'data_cadastro': registrationDate,
      'ativo': isActive ? 1 : 0,
    };
  }

  // Cria um objeto UserModel a partir de um Map do banco de dados
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['nome_completo'],
      email: map['email'],
      cpf: map['cpf'], // Pode ser null aqui
      passwordHash: map['senha_hash'],
      dateOfBirth: map['data_nascimento'],
      address: map['endereco'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userType: map['tipo_usuario'],
      profilePictureUrl: map['url_foto_perfil'],
      registrationDate: map['data_cadastro'],
      isActive: map['ativo'] == 1,
    );
  }
}
