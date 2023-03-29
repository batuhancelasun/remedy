class UserCredentials {
  final String name;
  final String email;
  final String surname;
  UserCredentials(
      {required this.email, required this.name, required this.surname});
  Map<String, dynamic> toJson() => {
        'name': name,
        'surName': surname,
        'email': email,
      };
  static UserCredentials fromJson(Map<String, dynamic> json) => UserCredentials(
        name: json['name'],
        surname: json['surName'],
        email: json['email'],
      );
}
