// ignore_for_file: public_member_api_docs, sort_constructors_first
class Auth {
  final String id;
  final String userName;
  final String accessToken;
  final String refreshToken;
  final String email;
  final String firstName;
  final String lastName;

  const Auth({
    required this.id,
    required this.userName,
    required this.accessToken,
    required this.refreshToken,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'].toString(),
      userName: json['username'],
      accessToken: json['token'],
      refreshToken: json['refreshToken'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
