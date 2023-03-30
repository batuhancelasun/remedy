class UserCredentials {
  UserCredentials(
      {required this.email,
      required this.name,
      required this.surname,
      required this.gender,
      required this.idNumber,
      required this.bloodType});

  final String email;
  final String name;
  final String surname;
  final String gender;
  final String idNumber;
  final String bloodType;

  Map<String, dynamic> toJson() => {
        'name': name,
        'surName': surname,
        'email': email,
        'gender': gender,
        'idNumber': idNumber,
        'bloodType': bloodType,
      };

  static UserCredentials fromJson(Map<String, dynamic> json) => UserCredentials(
        name: json['name'],
        surname: json['surName'],
        email: json['email'],
        gender: json['gender'],
        idNumber: json['idNumber'],
        bloodType: json['bloodType'],
      );
}
