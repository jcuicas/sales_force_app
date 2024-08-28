// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'].toString(),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'image': image,
      };
}
