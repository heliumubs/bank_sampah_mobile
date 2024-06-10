class User {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  String password;
  String rememberToken;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      password: json['password'],
      rememberToken: json['remember_token'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a User object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'password': password,
      'remember_token': rememberToken,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Method to create a list of User objects from JSON data
  static List<User> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  // Method to convert a list of User objects to JSON data
  static List<Map<String, dynamic>> listToJson(List<User> users) {
    return users.map((user) => user.toJson()).toList();
  }
}
