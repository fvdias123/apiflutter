class User {
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String picture;

  User(
      {required this.id,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 'default_id',
      title: json['title'] ?? 'N/A',
      firstName: json['firstName'] ?? 'N/A',
      lastName: json['lastName'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      picture: json['picture'] ?? 'default_picture_url',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
