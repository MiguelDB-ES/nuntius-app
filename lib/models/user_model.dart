// lib/models/user_model.dart
class UserModel {
  final int? id; // ID pode ser nulo se o usuário ainda não foi salvo no DB
  final String fullName;
  final String email;
  final String? cpf; // Anulável, para CPF (Pessoa Física)
  final String passwordHash;
  final String? dateOfBirth; // Consistente com TEXT no SQLite, anulável
  final String? address;
  final double? latitude;
  final double? longitude;
  final String userType; // 'fisica' ou 'admin'
  final String? profilePictureUrl;
  final String registrationDate; // Consistente com TEXT no SQLite
  final bool isActive; // 1 para true, 0 para false no SQLite

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    this.cpf, // Não é 'required' pois é anulável
    required this.passwordHash,
    this.dateOfBirth,
    this.address,
    this.latitude,
    this.longitude,
    required this.userType, // Este é o parâmetro que define o tipo de usuário
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
      'cpf': cpf, // Pode ser null
      'senha_hash': passwordHash,
      'data_nascimento': dateOfBirth,
      'endereco': address,
      'latitude': latitude,
      'longitude': longitude,
      'tipo_usuario': userType, // Mapeia para a coluna 'tipo_usuario' no DB
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
      cpf: map['cpf'], // Pode ser null
      passwordHash: map['senha_hash'],
      dateOfBirth: map['data_nascimento'],
      address: map['endereco'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userType: map['tipo_usuario'], // Mapeia de 'tipo_usuario' no DB
      profilePictureUrl: map['url_foto_perfil'],
      registrationDate: map['data_cadastro'],
      isActive: map['ativo'] == 1,
    );
  }

  // NOVO: Método copyWith para facilitar a atualização de propriedades
  UserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? cpf,
    String? passwordHash,
    String? dateOfBirth,
    String? address,
    double? latitude,
    double? longitude,
    String? userType,
    String? profilePictureUrl,
    String? registrationDate,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      passwordHash: passwordHash ?? this.passwordHash,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userType: userType ?? this.userType,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      registrationDate: registrationDate ?? this.registrationDate,
      isActive: isActive ?? this.isActive,
    );
  }
}
