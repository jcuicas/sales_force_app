// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cliente {
  final String id;
  final String phone;
  final String company;
  final String address;

  Cliente({
    required this.id,
    required this.phone,
    required this.company,
    required this.address,
  });

  Map toJson() => {
      'id': id,
      'phone': phone,
      'company': company,
      'address': address
    };
}
