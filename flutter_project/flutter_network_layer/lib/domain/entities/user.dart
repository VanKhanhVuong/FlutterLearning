class AuthResponse {
  final User user;
  final String accessToken;
  final String tokenType;

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class UserResponse {
  final bool success;
  final User user;

  UserResponse({required this.success, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['user']),
      success: json['success'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? otpExpiresAt;
  final String? verificationCode;
  final String role;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.otpExpiresAt,
    this.verificationCode,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      otpExpiresAt: json['otp_expires_at'],
      verificationCode: json['verification_code'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
